package route

import (
	"skillup-be/app/module/health/handler"
	"skillup-be/app/module/health/service"
	"skillup-be/configs"
	"skillup-be/infrastructure/firebase"
	"skillup-be/infrastructure/logger"

	"github.com/gin-gonic/gin"
)

func RegisterHealthRoute(router *gin.RouterGroup, cfg *configs.Config, log logger.Logger) {
	fbClient, _ := firebase.Initialize(cfg, log)
	healthService := service.NewHealthService(cfg, fbClient)
	healthHandler := handler.NewHealthHandler(log, healthService)

	router.GET("/health", healthHandler.Check)
}
