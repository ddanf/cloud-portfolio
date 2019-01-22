import boto3
from botocore.client import Config
import zipfile

def lambda_handler(event, context):
    sns = boto3.resource('sns')
    topic = sns.Topic('arn:aws:sns:us-east-1:842451556088:portfolioDeployment')

    try:
        s3 = boto3.resource('s3', config=Config(signature_version='s3v4'))

        build_bucket = s3.Bucket('dwf-tmp')
        target_bucket = s3.Bucket('dwf-portfolio')

        # On Windows, this will need to be a different location than /tmp
        build_bucket.download_file('portfolioBuild.zip', '/tmp/portfolioBuild.zip')

        with zipfile.ZipFile('/tmp/portfolioBuild.zip') as myzip:
            for nm in myzip.namelist():
                obj = myzip.open(nm)
                target_bucket.upload_fileobj(obj, nm)
                target_bucket.Object(nm).Acl().put(ACL='public-read')

        print 'Job Done!'
        topic.publish(Subject="Portfolio Deployment Status", Message="portfolio deployed successfully")
    except:
        topic.publish(Subject="Portfolio Deployment FAILED", Message="portfolio deployment FAIILED!")
        raise

    return "Hello from Lambda"
