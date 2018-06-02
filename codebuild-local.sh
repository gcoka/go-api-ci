#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
BUILD_IMAGE_NAME="gemcook/docker:17.12.1-dind"

docker pull amazon/aws-codebuild-local:latest --disable-content-trust=false

docker run -it -v /var/run/docker.sock:/var/run/docker.sock -e "IMAGE_NAME=$BUILD_IMAGE_NAME" -e "ARTIFACTS=$SCRIPTPATH/codebuild-local/artifacts" -e "SOURCE=$SCRIPTPATH" amazon/aws-codebuild-local
