#!/usr/bin/env bash

# INPUTS

# INPUT_AWS_ACCESS_KEY_ID
AWS_ACCESS_KEY_ID=${INPUT_AWS_ACCESS_KEY_ID}
# INPUT_AWS_SECRET_ACCESS_KEY
AWS_SECRET_ACCESS_KEY=${INPUT_AWS_SECRET_ACCESS_KEY}
# INPUT_AWS_REGION
AWS_REGION=${INPUT_AWS_REGION}
# INPUT_COMMAND
# INPUT_SERVICE
# INPUT_CLUSTER

# fetch the most recent task

ECS_TASK=$(aws --profile="${AWS_PROFILE}" ecs list-tasks --cluster "${INPUT_CLUSTER}" --service="${INPUT_SERVICE}" | jq -r '.taskArns[]' | head -n 1)

RESULT=$(aws ecs execute-command \
  --cluster ${INPUT_CLUSTER} \
  --task ${ECS_TASK} \
  --command "${INPUT_COMMAND}")

echo "::set-output name=result::${RESULT}"
