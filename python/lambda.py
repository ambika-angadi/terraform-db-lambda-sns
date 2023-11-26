import json
import boto3
import uuid

def lambda_handler(event, context):
    # TODO implement
    message = event["Records"][0]["body"]
    
    s3 = boto3.client('s3')
    bucket_name = 'hello-s3-20231022w'
    file_name = str(uuid.uuid4()) + '.txt'
    file_content = message
    
    response = s3.put_object(
    Body=file_content,
    Bucket=bucket_name,
    Key=file_name,
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Your Data has been saved to'+file_name)
    }