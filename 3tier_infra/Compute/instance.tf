#Create your webserver instance
resource "aws_instance" "Web" {
  ami           = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer1"
  }
  count           = 1
  subnet_id       = aws_subnet.my_app-subnet.id
  key_name        = "Web-key"
  security_groups = [aws_security_group.App_SG.id]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.Web-Key.private_key_pem
      host        = aws_instance.Web[0].public_ip
    }
    inline = [
      "sudo yum install httpd  php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
    ]
  }

}