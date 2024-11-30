package logic

import (
	"context"
	"net/http"

	"ShavitBhopWeb/backend/crud"
	"ShavitBhopWeb/backend/internal/svc"
	"ShavitBhopWeb/backend/internal/types"
	"ShavitBhopWeb/backend/misc"

	"github.com/zeromicro/go-zero/core/logx"
)

type FindLatestWrLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
	w      http.ResponseWriter
}

// 最近WR
func NewFindLatestWrLogic(ctx context.Context, svcCtx *svc.ServiceContext, w http.ResponseWriter) *FindLatestWrLogic {
	return &FindLatestWrLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
		w:      w,
	}
}

func (l *FindLatestWrLogic) FindLatestWr(req *types.FindLatestWrReq) (resp *types.FindLatestWrResp, err error) {
	result, err := l.svcCtx.DbQuery.
		FindLatestWr(
			l.ctx,
			crud.FindLatestWrParams{
				Limit:  req.Limit,
				Offset: req.Offset,
			},
		)
	if err != nil {
		return nil, err
	}

	body, err := misc.MarshalJsonNumberAsStringValue(result)
	if err != nil {
		return nil, err
	}

	l.w.Write(body)

	return
}
