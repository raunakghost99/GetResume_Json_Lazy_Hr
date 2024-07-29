import boto3
import json

# Initialize DynamoDB resource outside the handler to take advantage of connection reuse
dynamodb = boto3.resource('dynamodb')


def lambda_handler(event, context):
    table_name = 'Resumes'
    
    try:
        # Parse the JSON data from the API Gateway event
        data = json.loads(event['body'])
        table = dynamodb.Table(table_name)
        resume_string = data.get('resume', {})
        resume_id = data.get('resumeId')
        # Construct the item to be inserted with only the 'resume' attribute
        item = {
            'resumeId' : resume_id,
            'resume': resume_string  # Store as a JSON string
        }
        response = table.put_item(Item = item)
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Successfully uploaded data to DynamoDB',id : data['id']})
        }
    
    except json.JSONDecodeError:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Invalid JSON format'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': f'Internal server error: {str(e)}'})
        }
