import boto3
import json
from jsonschema import validate, ValidationError

# Initialize DynamoDB resource outside the handler to take advantage of connection reuse
dynamodb = boto3.resource('dynamodb')

# Define the schema for JSON validation
schema = {
            "id": {"type": "string"},
            "name": {"type": "string"},
            "resume": {"type": "integer"}
        }

def lambda_handler(event, context):
    table_name = 'Resumes'
    
    try:
        # Parse the JSON data from the API Gateway event
        data = json.loads(event['body'])
        # Validate the JSON data
        validate(instance=data, schema=schema)
        dynamodb.put_item(TableName = table_name, Item = data,primary_key = data['id'])
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Successfully uploaded data to DynamoDB',id : data['id']})
        }
    
    except json.JSONDecodeError:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Invalid JSON format'})
        }
    except ValidationError as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': f'JSON validation error: {e.message}'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': f'Internal server error: {str(e)}'})
        }
