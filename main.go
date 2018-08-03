package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		msg := GetHello("nodemon")
		fmt.Println(msg)
		c.String(http.StatusOK, msg)
	})

	// health check
	r.GET("/ping", func(c *gin.Context) {
		c.String(http.StatusOK, "pong")
	})

	port := "3000"
	if p, ok := os.LookupEnv("PORT"); ok {
		port = p
	}

	r.Run(fmt.Sprintf(":%v", port))
}

// GetHello returns Hello message to the target
func GetHello(target string) string {
	return fmt.Sprintf("Hello %v", target)
}
