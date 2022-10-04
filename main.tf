resource "aws_wafv2_ip_set" "waf_ip_set" {
  name               = "${var.PROJECT_NAME}-WAF-IP-Set"
  description        = "Waf Ip Set for allowing specific IPs"
  scope              = var.WAF_IP_SET_SCOPE
  ip_address_version = var.WAF_IP_ADDRESS_VERSION
  addresses          = var.WAF_ALLOWED_IP_ADDRESS_LIST
  tags = {
    Name = "${var.PROJECT_NAME}IPSet"
  }
}


resource "aws_wafv2_web_acl" "waf_web_acl_rules" {
  name        = "${var.PROJECT_NAME}WafWebAclRules"
  description = "WAF WEB ACL for API Gateway"
  scope       = var.WAF_IP_SET_SCOPE
  default_action {
    block {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.WAF_SCOPE_CLOUDWATCH_METRICS
    metric_name                = "${var.PROJECT_NAME}WafWebAclRules"
    sampled_requests_enabled   = var.WAF_SCOPE_SAMPLED_REQUESTS
  }

  rule {
    name     = var.WAF_IP_SET_ALLOW
    priority = 1
    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.waf_ip_set.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS
      metric_name                = var.WAF_IP_SET_ALLOW
      sampled_requests_enabled   = var.WAF_IP_SET_ALLOW_SAMPLED_REQUESTS
    }
  }

  dynamic "rule" {
    for_each = toset(var.RULES)

    content {
      name     = rule.value.name
      priority = rule.value.priority
      override_action {
        none {}
      }
      statement {
        managed_rule_group_statement {
          name        = rule.value.managed_rule_group_statement_name
          vendor_name = rule.value.managed_rule_group_statement_vendor_name
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = false
      }
    }
  }
}


resource "aws_wafv2_web_acl_association" "waf_association" {
  count        = length(var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST) > 0 ? length(var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST) : 0
  resource_arn = element(var.WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST, count.index)
  web_acl_arn  = aws_wafv2_web_acl.waf_web_acl_rules.arn
}