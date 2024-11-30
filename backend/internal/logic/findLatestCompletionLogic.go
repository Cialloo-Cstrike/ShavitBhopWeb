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

type FindLatestCompletionLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
	w      http.ResponseWriter
}

// 最近完成
func NewFindLatestCompletionLogic(ctx context.Context, svcCtx *svc.ServiceContext, w http.ResponseWriter) *FindLatestCompletionLogic {
	return &FindLatestCompletionLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
		w:      w,
	}
}

func (l *FindLatestCompletionLogic) FindLatestCompletion(req *types.FindLatestCompletionReq) (resp *types.FindLatestCompletionResp, err error) {
	result, err := l.svcCtx.DbQuery.
		FindLatestCompletion(
			l.ctx,
			crud.FindLatestCompletionParams{
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
