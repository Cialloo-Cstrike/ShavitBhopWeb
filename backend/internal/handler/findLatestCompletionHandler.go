package handler

import (
	"net/http"

	"ShavitBhopWeb/backend/internal/logic"
	"ShavitBhopWeb/backend/internal/svc"
	"ShavitBhopWeb/backend/internal/types"

	"github.com/zeromicro/go-zero/rest/httpx"
)

// 最近完成
func FindLatestCompletionHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.FindLatestCompletionReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := logic.NewFindLatestCompletionLogic(r.Context(), svcCtx, w)
		_, err := l.FindLatestCompletion(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.Ok(w)
		}
	}
}
