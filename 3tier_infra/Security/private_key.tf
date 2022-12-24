#create a private key which can be used to login to the website

resource "tls_private_key" "web_key" {
  algorithm = "RSA"

}