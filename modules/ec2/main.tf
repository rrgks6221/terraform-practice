resource "aws_eip" "ec2_eip" {

}

resource "aws_instance" "terraform_practice" {
  # ubuntu v22
  ami                    = "ami-0c9c942bd7bf113a2"
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.ec2_security_group_id]
  subnet_id              = var.public_subnet_ids[0]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
  }

  tags = {
    "Name" = "terraform-practice-public-ec2"
  }
}

resource "aws_eip_association" "ec2_eip_association" {
  allocation_id = aws_eip.ec2_eip.id
  instance_id   = aws_instance.terraform_practice.id
}
