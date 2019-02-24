import boto3
import os
from boto3.dynamodb.conditions import Key, Attr

def delHandler(event, context):
    
    postId = event["postId"]
    
    dynamodb = boto3.resource('dynamodb')
    s3 = boto3.resource('s3')
    table = dynamodb.Table(os.environ['DB_TABLE_NAME'])

    if postId=="*":
        items = table.scan()
    else:
        items = table.query(
            KeyConditionExpression=Key('id').eq(postId)
        )

    # If the given key matches more than one item, then we will
    # exit.  Otherwise we will delete the item from the table 
    # and remove the mp3 file from the S3 bucket.
    if items.Count()>1:
        return "Key matches multiple records.  Delete on multiple records is not allowed."

    for item in items:
        # build the filename, get the s3 object and then delete
        # both the s3 object and the db item.
        # should check for existence?
        fileName = item['id'] + '.mp3'
        mp3 = s3.Object(os.environ['BUCKET_NAME'], fileName)
        mp3.Delete()
        item.Delete()
        
    return items["Items"]