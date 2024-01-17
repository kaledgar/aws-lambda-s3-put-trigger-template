import json
import os

from typing import Dict, Any, Union
import boto3
import datetime


def lambda_handler(event: Dict, context: Any):
    """Trigger something

    Args:
        event (Dict): _description_
        context (Any): _description_
    """
    # env
    aws_region = os.environ["REGION"]
    project_prefix = os.environ["PROJECT_PREFIX"]
    print(f"Env Variables : {aws_region}, {project_prefix}")
    print(parse_s3_event(event))


def parse_s3_event(event: Dict) -> tuple:
    """_summary_

    Args:
        event (Dict): _description_

    Returns:
        tuple: _description_
    """
    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = event["Records"][0]["s3"]["object"]["key"]
    return (bucket, key)
