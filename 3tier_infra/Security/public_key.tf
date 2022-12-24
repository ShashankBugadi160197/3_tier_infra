#save public key attirbutes from the gernerted key
resource "aws_key_pair" "app_instance_key" {
  key_name   = "Web-Key"
  public_key = tls_private_key.web_key.public_key_openssh

}