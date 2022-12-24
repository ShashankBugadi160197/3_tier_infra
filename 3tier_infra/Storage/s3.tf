
#define s3 id
locals {
  s3_origin_id = "s3-origin"
}

#create a bucket to upload your static data like images and gifs


resource "aws_s3_bucket_versioning" "demobucket12345" {

  bucket = aws_s3_bucket_versioning.demobucket12345.id
  acl    = "public-read-write"

  versioning_configuration {
    enabled = true
  }


  tags = {
    Name        = "demobucket12345"
    Environment = "Prod"
  }

  provisioner "local-exec" {
    command = "git clone https://github.com/vineets300/Webpage1.git web-server-image"
  }
}



#allow public access to the bucket

resource "aws_s3_bucket_public_access_block" "public_storage" {
  depends_on          = [aws_s3_bucket.demobucket12345]
  bucket              = "demobucket12345"
  block_public_acls   = false
  block_public_policy = false

}

#upload data to s3 bucket

resource "aws_s3_bucket_versioning" "Object1" {
  depends_on = [aws_s3_bucket.demobucket12345]
  bucket     = "demobucket12345"
  acl        = "public-read-write"
  key        = "Demo1.PNG"
  source     = "web-server-image/Demo1.PNG"
}



#create cloudfront distribution for cloudfront_domain_name

resource "aws_cloudfront_distribution" "tera_cloudfront1" {

  depends_on = [aws_s3_bucket_object.Object1]
  origin {
    domain_name = aws_s3_bucket.demobucket12345.bucket_regional_domain_name
    origin      = local.s3_origin_id
  }
  enabled = true
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true

  }
}