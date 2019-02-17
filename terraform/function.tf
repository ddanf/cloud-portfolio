// place function description in this file.

// <apiName_GET>
// <apiName_POST>
// <apiName_DELETE>

resource "aws_lambda_function" "getFunc" {
    function_name   = "${aws_api_gateway_rest_api.myAPI.name}_getHandler"

    s3_bucket       = "${aws_s3_bucket.build.id}"
    s3_key          = "getHandler.zip"

    role            = "${aws_iam_role.getRole.arn}"
    runtime         = "python3.7"
    handler         = "getHandler"
}

resource "aws_lambda_function" "postFunc" {
    function_name   = "${aws_api_gateway_rest_api.myAPI.name}_postHandler"

    s3_bucket       = "${aws_s3_bucket.build.id}"
    s3_key          = "postHandler.zip"

    role            = "${aws_iam_role.postRole.arn}"
    runtime         = "python3.7"
    handler         = "postHandler"
}

resource "aws_lambda_function" "delFunc" {
    function_name   = "${aws_api_gateway_rest_api.myAPI.name}_delHandler"

    s3_bucket       = "${aws_s3_bucket.build.id}"
    s3_key          = "delHandler.zip"

    role            = "${aws_iam_role.delRole.arn}"
    runtime         = "python3.7"
    handler         = "delHandler"
}