import json, urllib, boto3, csv
from boto3.dynamodb.conditions import Key, Attr

# Connect to DynamoDB
dynamodb = boto3.resource('dynamodb')

# Connect to the DynamoDB tables
aisleTable = dynamodb.Table('aisle')
categoryAisleTable = dynamodb.Table('category-aisle')

def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'body': err.message if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
        },
    }

# This handler is executed every time the Lambda function is triggered
def lambda_handler(event, context):
    # Show the incoming event in the debug log
    resource = event['path'].split("/")
    shopName = urllib.request.unquote(resource[2])
    aisleNumber = urllib.request.unquote(resource[3])
    
    categories = categoryAisleTable.scan(FilterExpression=Attr('shopName').eq(shopName) & Attr('aisleNumber').eq(aisleNumber))['Items']
    for c in categories:
        categoryAisleTable.delete_item(Key={"shopName": shopName, "category": c['category']})

    print("Event received by lamda function: " + json.dumps(event, indent=2))
    result = aisleTable.delete_item(
        Key={
        'shopName': shopName,
        'aisleNumber': aisleNumber
        }
    )
    return respond(None, result)