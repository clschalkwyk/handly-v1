package main

import (
	"github.com/clschalkwyk/handly-v1/routes"
	"github.com/labstack/echo/v4"
	"net/http"
	"os"

	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// Create a new instance of Echo
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.CORS())

	// Routes
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Welcome to Local Service Finder API")
	})

	e.GET("/health", healthCheck)

	// Register Routes
	routes.RegisterRoutes(e)
	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	e.Logger.Fatal(e.Start(":" + port))
}

// Health check handler
func healthCheck(c echo.Context) error {
	return c.JSON(http.StatusOK, map[string]string{"status": "ok"})
}
