###########################################################################################
#                                     ESSENTIAL                                           #
###########################################################################################
output "PROJECT_NAME" {
 value       = var.PROJECT_NAME
 description = "The project name that will be prefixed to resource names"
}

############################################################################################
#                                      STRUCTURAL                                          #
############################################################################################
output "WAF_IP_ADDRESS_VERSION" {
  value       = var.WAF_IP_ADDRESS_VERSION
  description = "Specify IPV4 or IPV6. Valid values are IPV4 or IPV6"
}

output "WAF_ALLOWED_IP_ADDRESS_LIST" {
  value       = var.WAF_ALLOWED_IP_ADDRESS_LIST
  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR / with /32) notation."
}

output "WAF_IP_SET_SCOPE" {
  value       = var.WAF_IP_SET_SCOPE
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
}

output "WAF_IP_SET_ALLOW" {
  value       = var.WAF_IP_SET_ALLOW
  description = "Name for AWS Managed IP Set Allowing Rules"
}

output "WAF_SCOPE_CLOUDWATCH_METRICS" {
  value       = var.WAF_SCOPE_CLOUDWATCH_METRICS
  description = "Whether the associated resource sends metrics to CloudWatch"
}

output "WAF_SCOPE_SAMPLED_REQUESTS" {
  value       = var.WAF_SCOPE_SAMPLED_REQUESTS
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

output "WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS" {
  value       = var.WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS
  description = "Whether the associated resource sends metrics to CloudWatch"
}

output "WAF_IP_SET_ALLOW_SAMPLED_REQUESTS" {
  value       = var.WAF_IP_SET_ALLOW_SAMPLED_REQUESTS
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

output "RULES" {
  value       = var.RULES
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
}

output "WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST" {
  value       = var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST
  description = "A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage"
}