package route

import (
	"net/http"
	"path/filepath"

	"skillup-be/configs"
	"skillup-be/infrastructure/logger"
	"skillup-be/pkg/common/response"

	"github.com/gin-gonic/gin"
)

func RegisterRoutes(router *gin.Engine, cfg *configs.Config, log logger.Logger) {

	// API routes group
	apiGroup := router.Group("/api")
	{
		RegisterHealthRoute(apiGroup, cfg, log)
	}

	RegisterSwaggerRoute(router, cfg, log)

	// Home route
	router.GET("/", func(c *gin.Context) {
		c.File(filepath.Join("public", "index.html"))
	})

	// 404 handler
	router.NoRoute(func(c *gin.Context) {
		if len(c.Request.URL.Path) >= 4 && c.Request.URL.Path[:4] == "/api" {
			response.NotFound(c, "API route not found")
			return
		}
	})

	// 403 method not allowed
	router.NoMethod(func(c *gin.Context) {
		response.ErrorWithCode(c, http.StatusMethodNotAllowed, "METHOD_NOT_ALLOWED", "Method not allowed")
	})
}
