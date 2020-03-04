#!/bin/bash

CI_PROJECT_NAMESPACE="$1"
CI_PROJECT_NAME="$2"
CI_COMMIT_SHA="$(echo $3 | cut -c -8 )"
CI_BUILD_TOKEN="$4"
REGISTRY_URL="$5"

cd /opt/${CI_PROJECT_NAMESPACE}/
echo -e " Group: $CI_PROJECT_NAMESPACE\n Project name: $CI_PROJECT_NAME\n Commit: $CI_COMMIT_SHA\n Token: $CI_BUILD_TOKEN\n Registry: $REGISTRY_URL"
#sudo docker login -u gitlab-ci-token -p $CI_BUILD_TOKEN ${REGISTRY_URL}
sudo docker-compose stop ${CI_PROJECT_NAME}
sudo sed "s/\/"$CI_PROJECT_NAME":..*/\/"$CI_PROJECT_NAME":"$CI_COMMIT_SHA"/g" -i docker-compose.yml
sudo docker-compose up -d ${CI_PROJECT_NAME}