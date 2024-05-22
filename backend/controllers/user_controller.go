package controllers

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

type UserController struct{}

func (uc *UserController) PingUsers(c echo.Context) error {
	return c.String(http.StatusOK, "Pinging users")
}
