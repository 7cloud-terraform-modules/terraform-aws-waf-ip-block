############################################################################################
#                                      ESSENTIAL                                           #
############################################################################################
variable "PROJECT_NAME" {
  type        = string
  description = "The project name that will be prefixed to resource names"
  default = ""
}

############################################################################################
#                                      STRUCTURAL                                          #
############################################################################################

variable "WAF_IP_ADDRESS_VERSION" {
  type        = string
  description = "Specify IPV4 or IPV6. Valid values are IPV4 or IPV6"
}

variable "WAF_ALLOWED_IP_ADDRESS_LIST" {
  type        = list(string)
  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR / with /32) notation."
}

variable "WAF_IP_SET_SCOPE" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
}

variable "WAF_IP_SET_ALLOW" {
  type        = string
  description = "Name for AWS Managed IP Set Allowing Rules"
}

variable "WAF_SCOPE_CLOUDWATCH_METRICS" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch"
}

variable "WAF_SCOPE_SAMPLED_REQUESTS" {
  type        = bool
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

variable "WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch"
}

variable "WAF_IP_SET_ALLOW_SAMPLED_REQUESTS" {
  type        = bool
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

variable "RULES" {
  type        = list(any)
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
  default     = []
}

variable "WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST" {
  type        = list(string)
  description = "A list for the Amazon Resource Name (ARN) of the resources to associate with the web ACL. Must be ARN(S) of an Application Load Balancer or an Amazon API Gateway stage"
  default     = []
}