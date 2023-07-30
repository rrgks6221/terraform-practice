resource "aws_eip" "ec2_eip" {

}

resource "aws_instance" "free_tier" {
  # Amazon linux2 ami
  ami                    = "ami-0e4a9ad2eb120e054"
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_free_tier.id]
  subnet_id              = var.public_subnet_ids[0]


  tags = {
    "Name" = "${var.app_name_dash}-public-ec2"
  }
}

resource "aws_eip_association" "ec2_eip_association" {
  allocation_id = aws_eip.ec2_eip.id
  instance_id   = aws_instance.free_tier.id
}
