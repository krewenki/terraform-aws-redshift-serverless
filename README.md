# AWS Redshift Serverless Terraform module

Terraform module which creates Redshift Serverless resources on AWS.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

```hcl
module "redshift-serverless" {
  source  = "krewenki/redshift-serverless"

}
```

## Examples

- [Complete Redshift Serverless example](https://github.com/krewenki/terraform-aws-redshift-serverless/tree/master/examples/complete) creates VPC with Redshift subnet, VPC security group and Redshift Serverless namespace itself.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Warren Krewenki](https://github.com/krewenki).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/krewenki/terraform-aws-redshift-serverless/tree/main/LICENSE) for full details.
