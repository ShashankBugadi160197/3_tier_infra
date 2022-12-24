#create a block volume for data persistence

resource "aws_ebs_volume" "myebs1" {
  availability_zone = aws_instance.ec2.availability_zone
  size              = 1
  tags = {
    name = "ebsvol"
  }

}



#attach the volume to your instance

resource "aws_volume_attachment" "attach_ebs" {
  depends_on   = [aws_ebs_volume.myebs1]
  device_name  = "/dev/sdh"
  volume_id    = aws_ebs_volume.myebs1.id
  instance_id  = aws_insatence.ec2.id
  force_detach = true

}