#mount the volume to resource

resource "null_resource" "nullmount" {
  depends_on = [aws_volume_attachment.attach_ebs]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.web_key.private_key_pem
    host        = aws_instance.ec2.public_ip

  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdh",
      "sudo mount /dev/xvdh /var/www/html",
      "sudo rm -rf /var/www/html/*",
      "sudo git clone https://github.com/vineets300/Webpage1.git  /var/www/html" #cloned git profile
    ]
  } 
}



#update the CDN image URL to webserver code.

resource "null_resource" "Write_Image" {
  depends_on = [aws_cloudfront_distribution.tera_cloudf1]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.web_key.private_key_pem
    host        = aws_instance.ec2.public_ip

  }
  provisioner "remote-exec" {
    inline = [
      "sudo su << EOF",
      "echo \"<img src='http://${aws_cloudfront_distribution.tera_cloudf1.domain_name}/${aws_s3_bucket_object.obj1.key}'  width='300' height='380'>\" >>/var/www/html/index.html",
      "echo \"</body>\" >>/var/www/html/index.html",
      "echo \"</html>\" >>/var/www/html/index.html",
      "EOF",
    ]
  }
}




#success message and storing the result in a file

resource "null_resource" "result" {
  depends_on = [null_resource.nullmount]
  provisioner "local-exec" {
    command = "echo the website has been deployed successfully and >> result.txt  && echo the IP of the website is  ${aws_instance.ec2.public_ip} >>result.txt"

  }

}

#Testing  the application
resource "null_resource" "running_the_website" {
  depends_on = [null_resource.Write_Image]
  provisioner "local-exec" {
    command = "start chrome ${aws_instance.ec2.public_ip}"
  }
}