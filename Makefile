EXE_NAME=goapi

.PHONY: start
start:
	nodemon -x "pkill $(EXE_NAME) & (go build -v -o $(EXE_NAME) main.go || exit 1) && ./$(EXE_NAME)"

.PHONY: dep
dep:
	dep ensure

ecr-repository:
	aws ecr create-repository --repository-name go-api-ci2 --region us-east-1
