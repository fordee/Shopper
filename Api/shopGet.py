import json, urllib, boto3, csv
from boto3.dynamodb.conditions import Key, Attr



def getCategories(shopName, aisleNumber):
  ret = []
  for category in categories:
    #print('shop: ' + category['shop'] + ', aisleNumber: ' + category['aisleNumber'] + ', category: ' + category['category'])
    #print('shop: ' + shopName + ', aisleNumber: ' + aisleNumber + '\n\n\n') 
    if shopName == category['shop'] and aisleNumber == category['aisleNumber']:
      #print('true')
      ret.append(category['category'])
  
  return ret



dynamodb = boto3.resource('dynamodb')

# Connect to the DynamoDB tables
shopTable = dynamodb.Table('shop')
aisleTable = dynamodb.Table('aisle')
categoryAisleTable = dynamodb.Table('category-aisle')

shops = shopTable.scan()['Items']
categories = categoryAisleTable.scan()['Items']

print(categories)

ret = []
for shop in shops:
  shopName = shop['name']
  aisles = aisleTable.query(KeyConditionExpression=Key('shopName').eq(shopName))['Items']
  for aisle in aisles:
    del aisle['shopName']
    aisle['categories'] = getCategories(shopName, aisle['aisleNumber'])
  ret.append({'name': shopName, 'aisles': aisles})

print(json.dumps({'shops': ret},indent=2))

