import os

import boto3
import logging

logging.getLogger().setLevel(logging.INFO)

# env
aws_region = os.environ["AWS_REGION"]
project_prefix = os.environ["PROJECT_PREFIX"]


def lambda_handler(event, context):
    return 0
