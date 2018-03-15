EXE_NAME=goapi

.PHONY: start
start:
	nodemon -x "pkill $(EXE_NAME) & go build -v -o $(EXE_NAME) main.go && ./$(EXE_NAME)"
