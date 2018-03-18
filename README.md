# go-api-ci

![codebuild](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiK3BCTGJmdzFRYW5rZjdyN0dVMzhySStMQU5DQ0crZ0d1UFEwLzFyc3V0ekxlbmNLTmJFbXpiblFRWW5WZll5QUNJdUZiaFYyRUJKakhmZXRGN2toaEZrPSIsIml2UGFyYW1ldGVyU3BlYyI6IlpCWVBFbG16SmhMYnNUZ0YiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

## Setup

### Install tools

install `nodemon` command for live reloading.

```sh
# npm
npm i -g nodemon
# yarn
yarn global add nodemon
```

### AWS CodeBuild

Follow this article.
<https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker-custom-image.html>

### AWS ECR

1. create repository.
    `aws ecr create-repository --repository-name go-api-ci --region us-east-1 --profile xxxx`

2. Follow this article.
    <https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html>

## Getting Started

 Run `make dep` command.

```sh
make dep
```

Start the server.

```sh
make start
```

Access localhost on port 3000.

<localhost:3000>
