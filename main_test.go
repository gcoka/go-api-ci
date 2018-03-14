package main

import "testing"

func TestGetHello(t *testing.T) {
	type args struct {
		target string
	}
	tests := []struct {
		name string
		args args
		want string
	}{
		// TODO: Add test cases.
		{"Gin", args{"Gin"}, "Hello Gin"},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := GetHello(tt.args.target); got != tt.want {
				t.Errorf("GetHello() = %v, want %v", got, tt.want)
			}
		})
	}
}
