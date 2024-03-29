resource "aws_s3_bucket" "orsade-website" {
  bucket = "www.orsade.click"
}

resource "aws_s3_bucket_website_configuration" "orsade-website" {
  bucket = aws_s3_bucket.orsade-website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "eror.html"
  }
}

resource "aws_s3_object" "orsade-website-objects-imagesANDpdf" {
  bucket = aws_s3_bucket.orsade-website.id
  for_each = fileset("../My Site/images/", "**/*")
  key      = each.value
  source   = "../My Site/images/${each.value}"
}

resource "aws_s3_object" "orsade-website-objects-index-html" {
  bucket       = aws_s3_bucket.orsade-website.id
  key          = "index.html"
  source       = "../My Site/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "orsade-website-objects-eror-html" {
  bucket       = aws_s3_bucket.orsade-website.id
  key          = "eror.html"
  source       = "../My Site/eror.html"
  content_type = "text/html"
}


resource "aws_s3_object" "orsade-website-objects-css" {
  bucket       = aws_s3_bucket.orsade-website.id
  key          = "style.css"
  source       = "../My Site/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "orsade-website-objects-js" {
  bucket = aws_s3_bucket.orsade-website.id
  key    = "script.js"
  source = "../My Site/script.js"
}

resource "aws_s3_bucket_public_access_block" "ReadOnly-All" {
  bucket                  = aws_s3_bucket.orsade-website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "time_sleep" "wait_30s" {
  create_duration = "30s"
}

resource "aws_s3_bucket_policy" "orsade-website-bucket-policy" {
  depends_on = [aws_s3_bucket.orsade-website, time_sleep.wait_30s]
  bucket = aws_s3_bucket.orsade-website.id

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

