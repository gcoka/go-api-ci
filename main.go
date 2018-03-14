package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, GetHello("world"))
	})

	r.Run(":3000")
}

// GetHello returns Hello message to the target
func GetHello(target string) string {
	return "Hello " + target
}
