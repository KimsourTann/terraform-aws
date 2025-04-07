import json
import boto3
import urllib.parse

s3 = boto3.client("s3")

def lambda_handler(event, context):
    print("Received event:", json.dumps(event, indent=2))

    body = json.loads(event["body"])
    print("Received Body:", body)
    bucket = body["bucket"]
    object_key = body["object"]
    key = urllib.parse.unquote_plus(object_key)

    params = {
        "Bucket": bucket,
        "Key": key,
    }

    try:
        response = s3.get_object(**params)
        content = response["Body"].read().decode("utf-8")
        
        # Return the response in the required API Gateway format
        return {
            "statusCode": 200,
            "body": json.dumps({"message": content + " works!!!"}),
            "headers": {
                "Content-Type": "application/json"
            }
        }
        
    except Exception as e:
        print(e)
        message = f"Error getting object {key} from bucket {bucket}."
        
        # Return error response
        return {
            "statusCode": 500,
            "body": json.dumps({"error": message, "details": str(e)}),
            "headers": {
                "Content-Type": "application/json"
            }
        }
