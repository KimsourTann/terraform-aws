import json

def lambda_handler(event, context):
    # TODO implement
    # print(event)
    # if json.loads(event['body'])['name'] == 'kimsour':
    #     return {
    #         'statusCode': 200,
    #         'body': json.dumps('Hello from SOURER!')
    #     }
    # else:
    #     return {
    #         'statusCode': 400,
    #         'body': json.dumps('Hello from Lambda!')
    #     }
    return {
            'statusCode': 200,
            'body': json.dumps('Hello from Kimsour!')
        }
