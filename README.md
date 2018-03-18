# go-api-ci

![codebuild](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiK3BCTGJmdzFRYW5rZjdyN0dVMzhySStMQU5DQ0crZ0d1UFEwLzFyc3V0ekxlbmNLTmJFbXpiblFRWW5WZll5QUNJdUZiaFYyRUJKakhmZXRGN2toaEZrPSIsIml2UGFyYW1ldGVyU3BlYyI6IlpCWVBFbG16SmhMYnNUZ0YiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

## Setup

### Install tools

Install `nodemon` command for live reloading development.

```sh
# npm
npm i -g nodemon
# yarn
yarn global add nodemon
```

### AWS CodeBuild

Follow this article.
<https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker-custom-image.html>

add `AWS_DEFAULT_REGION: <your ecr region>` to environment variables.
add `AWS_ACCOUNT_ID: <your aws account id>` to environment variables.

### AWS ECR

1. Create repository.
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
