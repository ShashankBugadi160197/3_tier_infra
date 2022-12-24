#save key to your local system

resource "local_file" "web_key" {
  content  = tls_private_key.web_key.private_key_pem
  filename = "web_key.pem"

}