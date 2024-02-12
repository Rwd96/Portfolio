module "s3" {
  source = "./modules/s3"
}

module "ACM" {
  source = "./modules/acm"
}

module "cloud_front" {
  source = "./modules/cloud front"
aws_s3_bucket_bucket_domain_name = module.s3.aws_s3_bucket_bucket_domain_name
orsade_click_acm_arn = module.route_53.orsade_click_acm_arn
aws_s3_bucket_website_configuration-orsade-website = module.s3.aws_s3_bucket_website_configuration-orsade-website

}

module "route_53" {
  source = "./modules/route 53"
  aws_s3_bucket_id = module.s3.aws_s3_bucket_id
orsade_click_cloudfront_hosted_zone_id = module.cloud_front.orsade_click_cloudfront_hosted_zone_id
orsade_click_cloudfront_hosted_zone_domain_name = module.cloud_front.orsade_click_cloudfront_hosted_zone_domain_name
}

