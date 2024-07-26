import unittest
from lambda_post_function import lambda_handler
import boto3
import json
from moto import mock_dynamodb2

class TestLambdaPostFunction(unittest.TestCase):
    
    def setUp(self):
        self.data = {
            'id': 1,
            'name': 'John Doe',
            'resume': 100
        }
        self.table = self.dynamodb.create_table(
            TableName='MyTable',
            KeySchema=[
                {
                    'AttributeName': 'id',
                    'KeyType': 'HASH'
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': 'id',
                    'AttributeType': 'S'
                }
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits': 5,
                'WriteCapacityUnits': 5
            }
        )
        self.table.wait_until_exists()
        self.table.put_item(Item={'id': '123', 'name': 'test item'})

    @mock_dynamodb2
    def test_json_parsing(self):
        event = {'body': json.dumps(self.data)}
        response = lambda_handler(event, None)
        self.assertEqual(response['statusCode'], 200)
        # Check that the data was stored in DynamoDB
        table = boto3.resource('dynamodb').Table('Resumes')
        item = table.get_item(Key={'id': self.data['id']})
        self.assertIsNotNone(item)
        self.assertEqual(item['name'], self.data['name'])
        self.assertEqual(item['resume'], self.data['resume'])

    def test_invalid_json(self):
        event = {'body': 'Invalid JSON data'}
        response = lambda_handler(event, None)
        self.assertEqual(response['statusCode'], 400)
    
    def test_table_creation(self):
        event = {'body': json.dumps(self.data)}
        response = lambda_handler(event, None)
        self.assertEqual(response['statusCode'], 200)
        # Check that the table was created
        table = boto3.resource('dynamodb').Table('Resumes')
        
        self.assertIn('Resumes', tables)

    def test_dynamodb_error(self):
        event = {'body': json.dumps(self.data)}
        # Mock the put_item method to raise an exception
        dynamodb.Table.put_item.side_effect = Exception('DynamoDB error')
        response = lambda_handler(event, None)
        self.assertEqual(response['statusCode'], 500)