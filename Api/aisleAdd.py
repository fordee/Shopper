import json, urllib, boto3, csv

# Connect to DynamoDB
dynamodb = boto3.resource('dynamodb')

# Connect to the DynamoDB tables
aisleTable = dynamodb.Table('aisle')

def respond(err, res=None):
    return {
        'statusCode': '400' if err else '201',
        'body': err.message if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
        },
    }

# This handler is executed every time the Lambda function is triggered
def lambda_handler(event, context):
  # TODO: Confirm that shop exists


  data = event['body']
	
  print("Event received by lamda function: " + json.dumps(event, indent=2))
  result = aisleTable.put_item(Item=json.loads(data))
  return respond(None, data)