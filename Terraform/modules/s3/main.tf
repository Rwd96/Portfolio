resource "aws_s3_bucket" "orsade-website" {
  bucket = "www.orsade.click"
}

resource "aws_s3_object" "orsade-website-objects-imagesANDpdf" {
  bucket = aws_s3_bucket.orsade-website.bucket
  for_each = fileset("../My Site/images/", "**/*")
  key      = each.value
  source   = "../My Site/images/${each.value}"
}

resource "aws_s3_object" "orsade-website-objects-html" {
  bucket       = aws_s3_bucket.orsade-website.bucket
  key          = "index.html"
  source       = "../My Site/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "orsade-website-objects-css" {
  bucket       = aws_s3_bucket.orsade-website.bucket
  key          = "style.css"
  source       = "../My Site/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "orsade-website-objects-js" {
  bucket = aws_s3_bucket.orsade-website.bucket
  key    = "script.js"
  source = "../My Site/script.js"
}

resource "aws_s3_bucket_website_configuration" "orsade-website-configuration" {
  bucket = aws_s3_bucket.orsade-website.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "ReadOnly-All" {
  bucket                  = aws_s3_bucket.orsade-website.bucket
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "orsade-website-bucket-policy" {
  depends_on = [aws_s3_bucket.orsade-website]

  bucket = aws_s3_bucket.orsade-website.bucket

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": [
        "arn:aws:s3:::www.orsade.click/*"
      ]
    }
  ]
}
EOF
}


#this is a test 