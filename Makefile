EXE_NAME=goapi
BUILD_CMD_LOCAL=go build -o $(EXE_NAME) main.go

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(patsubst %/,%,$(dir $(MAKEFILE_PATH)))
BUILD_IMAGE_NAME="gemcook/docker:17.12.1-dind"

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

.PHONY: codebuild-local
codebuild-local:
	docker pull amazon/aws-codebuild-local:latest --disable-content-trust=false
	docker run -it -v /var/run/docker.sock:/var/run/docker.sock -e "IMAGE_NAME=$(BUILD_IMAGE_NAME)" -e "ARTIFACTS=$(CURRENT_DIR)/codebuild-local/artifacts" -e "SOURCE=$(CURRENT_DIR)" amazon/aws-codebuild-local
