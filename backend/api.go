package main

import (
	"embed"
	"flag"
	"fmt"
	"io/fs"
	"net/http"
	"os"
	"path"
	"strings"

	"ShavitBhopWeb/backend/internal/config"
	"ShavitBhopWeb/backend/internal/handler"
	"ShavitBhopWeb/backend/internal/svc"

	"github.com/zeromicro/go-zero/core/logx"
	"github.com/zeromicro/go-zero/rest"
)

var basename *string // 虚拟路由根路径

// public 为前端打包产物相对于 main 函数的路径
//
//go:embed public
var assets embed.FS

func main() {
	// Define flags for overriding specific fields
	host := flag.String("host", "0.0.0.0", "server host")
	port := flag.Int("port", 8080, "server port")
	basename = flag.String("basename", "/", "虚拟路由根路径")
	mysqlHost := flag.String("mysqlHost", "localhost", "MySQL host")
	mysqlPort := flag.String("mysqlPort", "3306", "MySQL port")
	mysqlUser := flag.String("mysqlUser", "root", "MySQL user")
	mysqlPass := flag.String("mysqlPass", "", "MySQL password")
	mysqlDB := flag.String("mysqlDB", "testdb", "MySQL database name")
	flag.Parse()

	// Initialize configuration with default values
	var c config.Config
	c.RestConf = rest.RestConf{
		Host: *host,
		Port: *port,
	}
	c.LogConf = logx.LogConf{
		Level: "info",
		Stat:  false,
	}
	c.MySQLConf = struct {
		Host   string
		Port   string
		User   string
		Pass   string
		DBName string
	}{
		Host:   *mysqlHost,
		Port:   *mysqlPort,
		User:   *mysqlUser,
		Pass:   *mysqlPass,
		DBName: *mysqlDB,
	}

	sub, _ := fs.Sub(assets, "public") // 读取对应目录下的内容，这里的public和上面embed目录（单目录，并非完整路径）对应
	fs := http.FS(sub)
	fileServer := http.FileServer(fs)
	server := rest.MustNewServer(c.RestConf,
		rest.WithNotFoundHandler(&NotFoundHandler{ // 自定义 NotFoundHandler，对虚拟路由做处理
			fs:         fs,
			fileServer: fileServer,
		}),
		rest.WithFileServer(*basename, fs))
	defer server.Stop()

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	fmt.Printf("Starting server at %s:%d...\n", c.RestConf.Host, c.RestConf.Port)
	server.Start()
}

type NotFoundHandler struct {
	fs         http.FileSystem
	fileServer http.Handler
}

func (n NotFoundHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	filePath := strings.TrimPrefix(path.Clean(r.URL.Path), *basename)
	if len(filePath) == 0 {
		filePath = *basename
	}

	file, err := n.fs.Open(filePath)
	switch {
	case err == nil:
		n.fileServer.ServeHTTP(w, r)
		_ = file.Close()
		return
	case os.IsNotExist(err):
		r.URL.Path = "/" // all virtual routes in react app means visit index.html
		n.fileServer.ServeHTTP(w, r)
		return
	default:
		http.Error(w, "not found", http.StatusNotFound)
		return
	}
}
