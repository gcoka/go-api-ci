# go-api-ci

![codebuild](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiK3BCTGJmdzFRYW5rZjdyN0dVMzhySStMQU5DQ0crZ0d1UFEwLzFyc3V0ekxlbmNLTmJFbXpiblFRWW5WZll5QUNJdUZiaFYyRUJKakhmZXRGN2toaEZrPSIsIml2UGFyYW1ldGVyU3BlYyI6IlpCWVBFbG16SmhMYnNUZ0YiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

## Setup

### Install tools

#### nodemon

Install `nodemon` command for live reloading development.

```sh
# npm
npm i -g nodemon
# yarn
yarn global add nodemon
```

#### ecs-cli

Install `ecs-cli` command for controll AWS ECS.
(NOTE: assuming aws-cli installed)

Mac

```sh
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-darwin-amd64-latest

sudo chmod +x /usr/local/bin/ecs-cli
```

Linux

```sh
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest

sudo chmod +x /usr/local/bin/ecs-cli
```

#### jq

Install `jq`

```sh
brew install jq
```

### Notice

for convenience. set environment variable `$AWS_CREDENTIAL`.

```sh
export AWS_CREDENTIAL=your-aws-profile-name
```

### AWS CodeBuild

Follow this article.
<https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker-custom-image.html>

add `AWS_DEFAULT_REGION: <your ecr region>` to environment variables.
add `AWS_ACCOUNT_ID: <your aws account id>` to environment variables.

### AWS ECR

1. Create repository.
    ```sh
    aws ecr create-repository --repository-name go-api-ci --region us-east-1 --profile $AWS_CREDENTIAL
    ```

2. Follow this article.
    <https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html>

### AWS ECS

1. Configure cluster.

    ```sh
    ecs-cli configure --region us-east-1 --cluster go-api-ci-cli --config-name go-api-ci-cli
    ```

2. Create cluster size 1.

    ```sh
    ecs-cli up --capability-iam --size 1 --instance-type t2.nano --keypair $YOUR_KEY --aws-profile $AWS_CREDENTIAL --cluster-config go-api-ci-cli
    ```

3. List cluster instances.

    ```sh
    aws ecs list-container-instances --cluster go-api-ci-cli --profile $AWS_CREDENTIAL
    ```
4. List cluster vpc and subnets.

    Check CloudFormation StackName.
    ```sh
    aws cloudformation list-stack-resources --profile $AWS_CREDENTIAL --stack-name amazon-ecs-cli-setup-go-api-ci-cli | jq '.StackResourceSummaries[] | select(.ResourceType | test("AWS::EC2::(Subnet$|VPC$)")) | {ResourceType, PhysicalResourceId}'
    ```

5. Get certificateArn.
    ```sh
    aws acm list-certificates --profile $AWS_CREDENTIAL | jq '.CertificateSummaryList[] | select(.DomainName=="xxxx.com")'
    ```

6. Create security group for Application Load Balancer.
    ```sh
    aws ec2 create-security-group --group-name HttpsALB --description "https alb security group" --vpc-id vpc-1a2b3c4d --profile $AWS_CREDENTIAL
    ```

7. Create Application Load Balancer.

    [ALB tutorial](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/tutorial-application-load-balancer-cli.html)

    Create load Balancer.
    ```sh
    aws elbv2 create-load-balancer --name go-api-ci-cli-alb --subnets subnet-12345678 subnet-23456789 --security-groups sg-12345678 --profile $AWS_CREDENTIAL
    ```
    Create target group.
    ```sh
    aws elbv2 create-target-group --name go-api-ci-cli-targets --protocol HTTP --port 80 --vpc-id vpc-12345678 --profile $AWS_CREDENTIAL
    ```
    Create https listner. (using AWS Console would be easy)
    ```sh
    aws elbv2 create-listener --load-balancer-arn $ALB_ARN --protocol HTTPS --port 443 --certificates CertificateArn=$CERTIFICATE_ARN --default-actions Type=forward,TargetGroupArn=$TARGETGROUP_ARN --profile $AWS_CREDENTIAL
    ```

8. Create Service.
    ```sh
    ecs-cli compose --file goapi.yml --target-group-arn $TARGETGROUP_ARN --container-name goapi --container-port 80 --cluster-config go-api-ci-cli --aws-profile $AWS_CREDENTIAL service up
    ```

9. Scale Service to size 2.
    ```sh
    ecs-cli scale --capability-iam --size 2 --aws-profile $AWS_CREDENTIAL --cluster-config go-api-ci-cli
    ecs-cli compose --file goapi.yml --cluster-config go-api-ci-cli --aws-profile $AWS_CREDENTIAL scale 2
    ```

10. Delete cluster.
    ```sh
    ecs-cli down --aws-profile $AWS_CREDENTIAL --cluster-config go-api-ci-cli

## Local Development

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
