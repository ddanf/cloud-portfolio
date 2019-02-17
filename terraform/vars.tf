variable "region" {
    default = "us-east-1"
}
variable "appName" {
    default = "myPortfolio"
    description = "the appName tag will be set to this value for all resources created by this config"
}

variable "web_bucket" {
    default = "myWebBucket"
    description = "name given to the web hosting bucket for the project"
}

variable "build_bucket" {
    default = "myBuildBucket"
    description = "name for the build bucket for the project"
}

variable "env" {
    default = "development"
    description = "name of the environment being deployed"
}