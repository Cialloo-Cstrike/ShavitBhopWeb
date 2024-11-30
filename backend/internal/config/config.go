package config

import (
	"github.com/zeromicro/go-zero/core/logx"
	"github.com/zeromicro/go-zero/rest"
)

type Config struct {
	rest.RestConf
	logx.LogConf

	MySQLConf struct {
		Host   string
		Port   string
		User   string
		Pass   string
		DBName string
	}
}
