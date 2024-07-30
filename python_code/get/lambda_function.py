
import json
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Resumes')

def lambda_handler(event, context):
    query_params = event.get('queryStringParameters', {})
    id_param = query_params.get('resumeId',None)
    try:
        response = table.get_item(
            Key={
                'resumeId': id_param
            }
        )
        item = response['Item']
        resume_data = item.get('resume')
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps(json.loads(resume_data), indent=4)
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }