import json, urllib, boto3, csv
from boto3.dynamodb.conditions import Key, Attr

# Connect to DynamoDB
dynamodb = boto3.resource('dynamodb')

# Connect to the DynamoDB tables
aisleTable = dynamodb.Table('aisle')
categoryAisleTable = dynamodb.Table('category-aisle')

def respond(err, res=None):
    return {
        'statusCode': '400' if err else '201',
        'body': err.message if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
        },
    }

def getAisles(shopName):
    aisleList = aisleTable.query(KeyConditionExpression=Key('shopName').eq(shopName))['Items']
    aisles = []
    for a in aisleList:
        aisle = {'aisle': a}
        categories = categoryAisleTable.scan(FilterExpression=Attr('shopName').eq(shopName) & Attr('aisleNumber').eq(a['aisleNumber']))['Items']
        aisle['categories'] = categories
        aisles.append(aisle)
    return aisles

def getAisleWith(aisleNumber, aisles):
    for a in aisles:
        if a['aisle']['aisleNumber'] == aisleNumber:
            return a
    return None

def incrementAisleNumberFrom(aisleNumber, aisles):
    aisleNumberInt = int(aisleNumber)
    for a in aisles:
        aAisleNumberInt = int(a['aisle']['aisleNumber'])
        if aAisleNumberInt >= aisleNumberInt:
            aAisleNumberInt += 1
            a['aisle']['aisleNumber'] = str(aAisleNumberInt)
            for c in a['categories']:
                c['aisleNumber'] = str(aAisleNumberInt)

def maxAisleNumber(aisles):
    maxAisleNo = 0
    for a in aisles:
        aAisleNumberInt = int(a['aisle']['aisleNumber']) 
        if aAisleNumberInt > maxAisleNo:
            maxAisleNo = aAisleNumberInt
    return str(maxAisleNo)

def deleteAisles(shopName, fromAisleNumber, maxAisleNo):
    fromAisleNumberInt = int(fromAisleNumber)
    maxAisleNumberInt = int(maxAisleNo)
    # Delete existing Aisles
    for i in range(fromAisleNumberInt, maxAisleNumberInt + 1):
        aisleTable.delete_item(Key={"shopName": shopName, "aisleNumber": str(i)})
        # Delete all categories
        categories = categoryAisleTable.scan(FilterExpression=Attr('shopName').eq(shopName) & Attr('aisleNumber').eq(str(i)))['Items']
        for c in categories:
            categoryAisleTable.delete_item(Key={"shopName": shopName, "category": c['category']})
        
def addAisles(shopName, fromAisleNumber, aisles):
    fromAisleNumberInt = int(fromAisleNumber)
    
    for a in aisles:
        print(a['aisle'])
        if int(a['aisle']['aisleNumber']) >= fromAisleNumberInt:
            aisleTable.put_item(Item=a['aisle'])

            for c in a['categories']:
                print(c)
                categoryAisleTable.put_item(Item=c)


# This handler is executed every time the Lambda function is triggered
def lambda_handler(event, context):
  # TODO: Confirm that shop exists


  data = event['body']
  jsonData = json.loads(data)

  shopName = jsonData['shopName']
  aisleNumber = jsonData['aisleNumber']
  aisles = getAisles(shopName)
  maxAisleNo = maxAisleNumber(aisles)
  thisAisle = getAisleWith(aisleNumber, aisles)
  
  if thisAisle != None:
    print("Need to move existing aisles up one")
    incrementAisleNumberFrom(aisleNumber, aisles)
    deleteAisles(shopName, aisleNumber, maxAisleNo)
    addAisles(shopName, aisleNumber, aisles)
	
  #print("Event received by lamda function: " + json.dumps(event, indent=2))
  result = aisleTable.put_item(Item=json.loads(data))
  return respond(None, data)