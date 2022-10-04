# WAF IP Block Module by 7Clouds

Base Networking Resources Module by 7Clouds
Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%! Check it out at <https://seventechnologies.cloud>

Please rank this repo 5 starts if you like our job!

## Usage

This module is set for blocking any non listed IP, it counts on waf ip set, waf web acl rules and waf association. By default, it is configured as regional scope and ipv4, but here is the beauty on using modules, you may easily suit it to your needs.

* Pre Deployment

1. To authorize IP's, fill the variable "WAF_ALLOWED_IP_ADDRESS_LIST" with allowed IP's as a list (with "/32" SUFFIX FOR IPV4). eg.: ["109.155.209.167/32", "172.0.0.1/32"].
For allowying your personal IPV4 it must be your external one.
2. It's also possible to configure it to IPV6. In this case you need to change the variables "WAF_IP_ADDRESS_VERSION" value for "IPV6" and check more details on [AWS DOCUMENTATION](https://docs.aws.amazon.com/pt_br/waf/latest/APIReference/API_wafRegional_IPSetDescriptor.html) for IP set description.
3. The variable "RULES" is a map for applying on a dynamic block, it's possible to adapt it to your needs.
4. For "aws_wafv2_web_acl_association", you need to reference an api gateway stage or load balancer arn in order to perform the association, otherwise the rules will not be attached to any resource and the association will not be created. That's the variable to place the value(s): WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST.

## Example

```hcl
#WAF IP BLOCK MODULE

module "waf_ip_block_module" {
  source = "../.."


#ESSENTIAL VARIABLE
  PROJECT_NAME = "test_project"

#STRUCTURAL VARIABLES
  WAF_IP_ADDRESS_VERSION                = "IPV4"
  WAF_ALLOWED_IP_ADDRESS_LIST           = []
  WAF_IP_SET_SCOPE                      = "REGIONAL"
  WAF_IP_SET_ALLOW                      = "IPSetAllow"
  WAF_SCOPE_CLOUDWATCH_METRICS          = true
  WAF_SCOPE_SAMPLED_REQUESTS            = false
  WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS   = true
  WAF_IP_SET_ALLOW_SAMPLED_REQUESTS     = false
  WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST = []
  RULES = [
    {
      name                                     = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_name        = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesSQLiRuleSet"
      priority                                 = 2
    },
    {
      name                                     = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_name        = "AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesSQLiRuleSet"
      priority                                 = 3
    },
    {
      name                                     = "AWSManagedRulesAnonymousIpList"
      managed_rule_group_statement_name        = "AWSManagedRulesAnonymousIpList"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name                              = "AWSManagedRulesAnonymousIpList"
      priority                                 = 4
    }
  ]
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

</br>

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

</br>

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_waf_ip_block_module"></a> [waf\_ip\_block\_module](#module\_waf\_ip\_block\_module) | ../.. | n/a |

</br>

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_ip_set.waf_ip_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.waf_web_acl_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.waf_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

</br>

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_PROJECT_NAME"></a> [PROJECT\_NAME](#input\_PROJECT\_NAME) | The project name that will be prefixed to resource names | `string` | "" | yes |
| <a name="input_RULES"></a> [RULES](#input\_RULES) | Rule blocks used to identify the web requests that you want to allow, block, or count | `list(any)` | `[]` | no |
| <a name="input_WAF_ALLOWED_IP_ADDRESS_LIST"></a> [WAF\_ALLOWED\_IP\_ADDRESS\_LIST](#input\_WAF\_ALLOWED\_IP\_ADDRESS\_LIST) | Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR / with /32) notation. | `list(string)` | n/a | yes |
| <a name="input_WAF_IP_ADDRESS_VERSION"></a> [WAF\_IP\_ADDRESS\_VERSION](#input\_WAF\_IP\_ADDRESS\_VERSION) | Specify IPV4 or IPV6. Valid values are IPV4 or IPV6 | `string` | n/a | yes |
| <a name="input_WAF_IP_SET_ALLOW"></a> [WAF\_IP\_SET\_ALLOW](#input\_WAF\_IP\_SET\_ALLOW) | Name for AWS Managed IP Set Allowing Rules | `string` | n/a | yes |
| <a name="input_WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS"></a> [WAF\_IP\_SET\_ALLOW\_CLOUDWATCH\_METRICS](#input\_WAF\_IP\_SET\_ALLOW\_CLOUDWATCH\_METRICS) | Whether the associated resource sends metrics to CloudWatch | `bool` | n/a | yes |
| <a name="input_WAF_IP_SET_ALLOW_SAMPLED_REQUESTS"></a> [WAF\_IP\_SET\_ALLOW\_SAMPLED\_REQUESTS](#input\_WAF\_IP\_SET\_ALLOW\_SAMPLED\_REQUESTS) | Whether AWS WAF should store a sampling of the web requests that match the rules | `bool` | n/a | yes |
| <a name="input_WAF_IP_SET_SCOPE"></a> [WAF\_IP\_SET\_SCOPE](#input\_WAF\_IP\_SET\_SCOPE) | Specifies whether this is for an AWS CloudFront distribution or for a regional application | `string` | n/a | yes |
| <a name="input_WAF_SCOPE_CLOUDWATCH_METRICS"></a> [WAF\_SCOPE\_CLOUDWATCH\_METRICS](#input\_WAF\_SCOPE\_CLOUDWATCH\_METRICS) | Whether the associated resource sends metrics to CloudWatch | `bool` | n/a | yes |
| <a name="input_WAF_SCOPE_SAMPLED_REQUESTS"></a> [WAF\_SCOPE\_SAMPLED\_REQUESTS](#input\_WAF\_SCOPE\_SAMPLED\_REQUESTS) | Whether AWS WAF should store a sampling of the web requests that match the rules | `bool` | n/a | yes |
| <a name="input_WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST"></a> [WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST](#input\_WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST) | A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage | `list(string)` | `[]` | no |

</br>

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_PROJECT_NAME"></a> [PROJECT\_NAME](#output\_PROJECT\_NAME) | The project name that will be prefixed to resource names |
| <a name="output_RULES"></a> [RULES](#output\_RULES) | Rule blocks used to identify the web requests that you want to allow, block, or count |
| <a name="output_WAF_ALLOWED_IP_ADDRESS_LIST"></a> [WAF\_ALLOWED\_IP\_ADDRESS\_LIST](#output\_WAF\_ALLOWED\_IP\_ADDRESS\_LIST) | Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR / with /32) notation. |
| <a name="output_WAF_IP_ADDRESS_VERSION"></a> [WAF\_IP\_ADDRESS\_VERSION](#output\_WAF\_IP\_ADDRESS\_VERSION) | Specify IPV4 or IPV6. Valid values are IPV4 or IPV6 |
| <a name="output_WAF_IP_SET_ALLOW"></a> [WAF\_IP\_SET\_ALLOW](#output\_WAF\_IP\_SET\_ALLOW) | Name for AWS Managed IP Set Allowing Rules |
| <a name="output_WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS"></a> [WAF\_IP\_SET\_ALLOW\_CLOUDWATCH\_METRICS](#output\_WAF\_IP\_SET\_ALLOW\_CLOUDWATCH\_METRICS) | Whether the associated resource sends metrics to CloudWatch |
| <a name="output_WAF_IP_SET_ALLOW_SAMPLED_REQUESTS"></a> [WAF\_IP\_SET\_ALLOW\_SAMPLED\_REQUESTS](#output\_WAF\_IP\_SET\_ALLOW\_SAMPLED\_REQUESTS) | Whether AWS WAF should store a sampling of the web requests that match the rules |
| <a name="output_WAF_IP_SET_SCOPE"></a> [WAF\_IP\_SET\_SCOPE](#output\_WAF\_IP\_SET\_SCOPE) | Specifies whether this is for an AWS CloudFront distribution or for a regional application |
| <a name="output_WAF_SCOPE_CLOUDWATCH_METRICS"></a> [WAF\_SCOPE\_CLOUDWATCH\_METRICS](#output\_WAF\_SCOPE\_CLOUDWATCH\_METRICS) | Whether the associated resource sends metrics to CloudWatch |
| <a name="output_WAF_SCOPE_SAMPLED_REQUESTS"></a> [WAF\_SCOPE\_SAMPLED\_REQUESTS](#output\_WAF\_SCOPE\_SAMPLED\_REQUESTS) | Whether AWS WAF should store a sampling of the web requests that match the rules |
| <a name="output_WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST"></a> [WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST](#output\_WEB\_ACL\_ASSOCIATION\_RESOURCE\_ARN\_LIST) | A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage |
<!-- END_TF_DOCS -->