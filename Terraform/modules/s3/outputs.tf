output "aws_s3_bucket_id" {
    description = "www.orsade.click s3 bucket id"
    value = aws_s3_bucket.orsade-website.id
}


output "aws_s3_bucket_bucket_domain_name" {
    description = "www.orsade.click s3 bucket domain name"
    value = aws_s3_bucket.orsade-website.bucket_domain_name
}

output "aws_s3_bucket_website_configuration-orsade-website" {
    description = "www.orsade.click s3 bucket website configuration"
    value = aws_s3_bucket_website_configuration.orsade-website.id
}






