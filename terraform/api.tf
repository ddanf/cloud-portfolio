// place API Gateway description in this file.
resource "aws_api_gateway_stage" "apiStageProd" {
  stage_name    = "prod"
  rest_api_id   = "${aws_api_gateway_rest_api.myAPI.id}"
  deployment_id = "${aws_api_gateway_deployment.apiDeploymentDev.id}"
}

resource "aws_api_gateway_deployment" "apiDeploymentDev" {
  depends_on  = ["aws_api_gateway_integration.getIntegration"]
  rest_api_id = "${aws_api_gateway_rest_api.myAPI.id}"
  stage_name  = "dev"
}
resource "aws_api_gateway_rest_api" "myAPI" {
  name        = "myAPI"
  description = "terraform-created API for the ${var.appName} application"
}

resource "aws_api_gateway_resource" "myApiResource" {
  rest_api_id = "${aws_api_gateway_rest_api.myAPI.id}"
  parent_id   = "${aws_api_gateway_rest_api.myAPI.root_resource_id}"
  path_part   = "myapiresource"
}

// GET : method -> integration -> lambda -> integration response -> method response
// POST: method -> integration -> lambda -> integration response -> method response
resource "aws_api_gateway_method" "myGetMethod" {
  rest_api_id   = "${aws_api_gateway_rest_api.myAPI.id}"
  resource_id   = "${aws_api_gateway_resource.myApiResource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_settings" "getSettings" {
  rest_api_id = "${aws_api_gateway_rest_api.myAPI.id}"
  stage_name  = "${aws_api_gateway_stage.apiStageProd.stage_name}"
  method_path = "${aws_api_gateway_resource.myApiResource.path_part}/${aws_api_gateway_method.myGetMethod.http_method}"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_integration" "getIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.myAPI.id}"
  resource_id = "${aws_api_gateway_resource.myApiResource.id}"
  http_method = "${aws_api_gateway_method.myGetMethod.http_method}"
  
  integration_http_method   = "GET"
  type                      = "AWS_PROXY"
  uri                       = "${aws_lambda_function.getFunc.invoke_arn}"
}

resource "aws_api_gateway_method_response" "200" {
  rest_api_id = "${aws_api_gateway_rest_api.myAPI.id}"
  resource_id = "${aws_api_gateway_resource.myApiResource.id}"
  http_method = "${aws_api_gateway_method.myGetMethod.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "getIntegrationResponse" {
  depends_on    = [
      "aws_api_gateway_integration.getIntegration"
  ]
  rest_api_id   = "${aws_api_gateway_rest_api.myAPI.id}"
  resource_id   = "${aws_api_gateway_resource.myApiResource.id}"
  http_method   = "${aws_api_gateway_method.myGetMethod.http_method}"
  status_code   = "${aws_api_gateway_method_response.200.status_code}"
}
