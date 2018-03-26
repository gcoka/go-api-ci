EXE_NAME=goapi
BUILD_CMD_LOCAL=go build -o $(EXE_NAME) main.go

.PHONY: start
start:
	nodemon -x "pkill $(EXE_NAME) & ($(BUILD_CMD_LOCAL) || exit 1) && (./$(EXE_NAME) || exit 1)"

.PHONY: dep
dep:
	dep ensure

ecr-repository:
	aws ecr create-repository --repository-name go-api-ci2 --region us-east-1

build-image:
	docker build -t gcoka/goapi .

push-image:
	docker push gcoka/goapi

