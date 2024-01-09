## Architecture Sketch
![image](https://github.com/kaledgar/s3-file-trigger-lambda/assets/101144906/c5cd5e94-afeb-4fbc-a4e7-d1ed3f2920c9)

## Prerequisites

 - aws-cli ~ 2.13
 - terraform ~ 1.6 installed, connected with AWS 

## Deploy

1. First create resources required for [remote backend](https://spacelift.io/blog/terraform-tutorial#remote-backends) (s3 + DynamoDB Table) - all resources in `infrastructure/main.tf`

    ```shell
    terraform init
    terraform apply
    ```
    
2. Uncomment `terraform` block in `infrastructure/main.tf` an re-deploy again using above commands.