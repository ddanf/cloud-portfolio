import boto3
from botocore.client import Config
import zipfile

def lambda_handler(event, context):
    sns = boto3.resource('sns')
    topic = sns.Topic('arn:aws:sns:us-east-1:842451556088:portfolioDeployment')
    location = {
        "bucketName": 'dwf-tmp',
        "objectKey": 'portfolioBuild.zip'
    }

    try:
        job = event.get("CodePipeline.job")

        if job:
            for artifact in job["data"]["inputArtifacts"]:
                if artifact["name"] == "MyAppBuild":
                    location = artifact["location"]["s3Location"]
                else:
                    print "artifact name = " + artifact["name"]
        print "Building portfolio from " + str(location)
        s3 = boto3.resource('s3', config=Config(signature_version='s3v4'))

        build_bucket = s3.Bucket(location["bucketName"])
        target_bucket = s3.Bucket('dwf-portfolio')

        # On Windows, this will need to be a different location than /tmp
        build_bucket.download_file(location["objectKey"], '/tmp/portfolioBuild.zip')

        with zipfile.ZipFile('/tmp/portfolioBuild.zip') as myzip:
            for nm in myzip.namelist():
                obj = myzip.open(nm)
                target_bucket.upload_fileobj(obj, nm)
                target_bucket.Object(nm).Acl().put(ACL='public-read')

        print 'Job Done!'
        topic.publish(Subject="Portfolio Deployment Status", Message="portfolio deployed successfully")

        if job:
            codepipeline = boto3.client('codepipeline')
            codepipeline.put_job_success_result(jobId=job["id"])

    except:
        topic.publish(Subject="Portfolio Deployment FAILED", Message="portfolio deployment FAIILED!")
        raise

    return "Complete"
