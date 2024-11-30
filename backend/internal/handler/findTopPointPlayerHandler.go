package handler

import (
	"net/http"

	"ShavitBhopWeb/backend/internal/logic"
	"ShavitBhopWeb/backend/internal/svc"
	"ShavitBhopWeb/backend/internal/types"

	"github.com/zeromicro/go-zero/rest/httpx"
)

// 最高分玩家
func FindTopPointPlayerHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.FindTopPointPlayerReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := logic.NewFindTopPointPlayerLogic(r.Context(), svcCtx, w)
		_, err := l.FindTopPointPlayer(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.Ok(w)
		}
	}
}
