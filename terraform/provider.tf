provider "aws" {
    /* pass keys with -var-file=<filename>: store files in a
       private directory outside of the project. */
    /* add region to tfvars files */
    region  ="${var.region}"
}

locals {
    common_tags = {
        Aplication  = "${var.appName}"
        Environment = "${var.env}"
    }
}