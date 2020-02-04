#!/bin/bash

set -eo pipefail

export AWS_PROFILE=sylgaws

BUCKET="syg-lambda-imagemagick-layer"

scripts/build.sh

aws cloudformation package \
  --s3-bucket "$BUCKET" \
  --s3-prefix imagemagick-layer \
  --template-file template.yaml \
  --output-template-file build/template-output.yaml

aws cloudformation deploy \
  --template-file build/template-output.yaml \
  --stack-name "LambdaImageMagickLayer"

aws lambda list-layers \
  --query "Layers[].LatestMatchingVersion.LayerVersionArn"
