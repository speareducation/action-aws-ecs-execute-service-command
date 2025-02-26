#!/usr/bin/env bash

# INPUTS

# INPUT_AWS_ACCESS_KEY_ID
export AWS_ACCESS_KEY_ID=${INPUT_AWS_ACCESS_KEY_ID}
# INPUT_AWS_SECRET_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=${INPUT_AWS_SECRET_ACCESS_KEY}
# INPUT_AWS_REGION
export AWS_REGION=${INPUT_AWS_REGION}
# INPUT_COMMAND
# INPUT_SERVICE
# INPUT_CLUSTER

# fetch the most recent task
ECS_TASK=$(aws \
  --region="${AWS_REGION}" \
  ecs list-tasks \
  --cluster "${INPUT_CLUSTER}" \
  --service="${INPUT_SERVICE}" | jq -r '.taskArns[]' | head -n 1)

UNBUFFER_COMMAND=$(which unbuffer) RESULT=$(${UNBUFFER_COMMAND} aws \
  --region="${AWS_REGION}" \
  ecs execute-command \
  --interactive \
  --color off \
  --cluster "${INPUT_CLUSTER}" \
  --task ${ECS_TASK} \
  --command "${INPUT_COMMAND}")

RESULT_CODE=$?

echo "result=${RESULT}" >> ${GITHUB_OUTPUT}

exit ${RESULT_CODE}
