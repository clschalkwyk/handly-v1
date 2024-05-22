package routes

import (
	"github.com/clschalkwyk/handly-v1/controllers"
	"github.com/labstack/echo/v4"
)

func RegisterRoutes(e *echo.Echo) {
	userController := &controllers.UserController{}

	// User Routes
	e.GET("/users", userController.PingUsers)
}
