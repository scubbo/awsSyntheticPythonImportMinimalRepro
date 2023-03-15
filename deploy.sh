#!/usr/bin/env bash

# Unless otherwise stated, when I refer to "Synthetics docs", I mean this page:
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_WritingCanary_Python.html

set -ex
(
  (
    cd testing_code || exit
    rm -rf venv # To simulate the "clean build" that would hapepn in CodeBuild.
    python3.8 -m venv venv
    source venv/bin/activate
    pip3 install -r requirements.txt
    zip -r packaged-synthetic.zip python venv
    mv packaged-synthetic.zip ..
  )

  echo "The list of all files in the zip:"
  unzip -l packaged-synthetic.zip
  echo "Ensure that \`synthetic.py\` is nested under \`python\`, as required by Synthetics Docs"
  unzip -l packaged-synthetic.zip | grep 'synthetic.py'

  # In a real deployment script this would be configurable, but this is just a proof-of-concept
  cdk --profile DevOps deploy
#  stackId=$(aws --profile DevOps cloudformation list-stacks | jq -r '.StackSummaries[] | select(.StackName=="ReproStack") | .StackId')
  aws --profile DevOps cloudformation wait stack-update-complete --stack-name ReproStack
  logGroupName=$(aws --profile DevOps logs describe-log-groups | jq -r '.logGroups[] | select(.logGroupName | startswith("/aws/lambda/cwsyn-reprostack")) | .logGroupName')
  aws --profile DevOps logs tail "$logGroupName" --follow
#  logStreamName=$(aws --profile DevOps logs describe-log-streams --log-group-name "$logGroupName" | jq -r '.logStreams[0].logStreamName')

)
rm -f packaged-synthetic.zip
