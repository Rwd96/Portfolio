// Certificate
resource "aws_acm_certificate" "orsade_click" {
  domain_name       = "orsade.click"
  subject_alternative_names = [ "www.orsade.click" ]
  validation_method = "DNS"
}



  // Route 53 Record ACM
resource "aws_route53_record" "orsade_click" {
  for_each = {
    for dvo in aws_acm_certificate.orsade_click.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.orsade_click_zone_id
}

// Certificate Validation
resource "aws_acm_certificate_validation" "orsade_click" {
  certificate_arn         = aws_acm_certificate.orsade_click.arn
  validation_record_fqdns = [for record in aws_route53_record.orsade_click : record.fqdn]
   
}

resource "aws_route53_record" "orsade_click_cloudfront" {
  zone_id = var.orsade_click_zone_id
  name    = "orsade.click"
  type    = "A"

  alias {
    name                   = var.orsade_click_cloudfront_hosted_zone_domain_name
    zone_id                = var.orsade_click_cloudfront_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_orsade_click_cloudfront" {
  zone_id = var.orsade_click_zone_id
  name    = "www.orsade.click"
  type    = "A"

  alias {
    name                   = var.orsade_click_cloudfront_hosted_zone_domain_name
    zone_id                = var.orsade_click_cloudfront_hosted_zone_id
    evaluate_target_health = true
  }
}