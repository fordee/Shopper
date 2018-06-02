import json, urllib, boto3, csv

# Connect to DynamoDB
dynamodb = boto3.resource('dynamodb')

# Connect to the DynamoDB tables
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
    print("resource: " + ", ".join(resource))
    print("resource 2: " + urllib.request.unquote(resource[2]) + ", resource 3: " + urllib.request.unquote(resource[3]))
    print("resource 4: " + urllib.request.unquote(resource[4]))

    # TODO: Delete categories associated with shopName and aisleNumber (keyed on Category)

    print("Event received by lamda function: " + json.dumps(event, indent=2))
    result = categoryAisleTable.delete_item(
        Key={
        'shop': urllib.request.unquote(resource[2]),
        'aisleNumber': urllib.request.unquote(resource[3]),
        'category': urllib.request.unquote(resource[4])
        }
    )
    return respond(None, result)