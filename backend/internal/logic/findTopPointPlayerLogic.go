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

type FindTopPointPlayerLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
	w      http.ResponseWriter
}

// 最高分玩家
func NewFindTopPointPlayerLogic(ctx context.Context, svcCtx *svc.ServiceContext, w http.ResponseWriter) *FindTopPointPlayerLogic {
	return &FindTopPointPlayerLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
		w:      w,
	}
}

func (l *FindTopPointPlayerLogic) FindTopPointPlayer(req *types.FindTopPointPlayerReq) (resp *types.FindTopPointPlayerResp, err error) {
	result, err := l.svcCtx.DbQuery.
		FindTopPlayerPoint(
			l.ctx,
			crud.FindTopPlayerPointParams{
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
