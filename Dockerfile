FROM gemcook/golang:1.10.0 as builder

ENV APPDIR=github.com/gcoka/go-api-ci

RUN mkdir -p $GOPATH/src/$APPDIR && cd $_
WORKDIR /go/src/github.com/gcoka/go-api-ci
COPY . .
RUN dep ensure
RUN go list ./... | xargs golint -set_exit_status
RUN go vet ./...
RUN go test ./...
RUN go build -o /tmp/goapi main.go

FROM alpine

COPY --from=builder /tmp/goapi /opt/api/goapi
ENV GIN_MODE=release
ENV PORT=80
CMD ["/opt/api/goapi"]
