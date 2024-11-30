package svc

import (
	"ShavitBhopWeb/backend/crud"
	"ShavitBhopWeb/backend/internal/config"
	"ShavitBhopWeb/backend/internal/middleware"
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
	"github.com/zeromicro/go-zero/rest"
)

type ServiceContext struct {
	Config             config.Config
	PublicAccessFilter rest.Middleware
	CorsAllMiddleware  rest.Middleware
	DbQuery            *crud.Queries
}

func NewServiceContext(c config.Config) *ServiceContext {
	db, err := sql.Open(
		"mysql",
		fmt.Sprintf(
			"%s:%s@tcp(%s:%s)/%s?parseTime=true",
			c.MySQLConf.User,
			c.MySQLConf.Pass,
			c.MySQLConf.Host,
			c.MySQLConf.Port,
			c.MySQLConf.DBName,
		),
	)
	if err != nil {
		panic(err)
	}

	return &ServiceContext{
		Config:             c,
		PublicAccessFilter: middleware.NewPublicAccessFilterMiddleware().Handle,
		CorsAllMiddleware:  middleware.NewCorsAllMiddleware().Handle,
		DbQuery:            crud.New(db),
	}
}
