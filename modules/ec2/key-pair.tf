# ec2-test라는 이름의 aws_key_pair라는 타입의 리소스를 정의한다.
resource "aws_key_pair" "key_pair" {
  # 생성될 키페어의 이름
  key_name = "terraform_practice_key_pair"
  # 키페어에 사용할 public key 지정
  public_key = file("~/.ssh/terraform_practice_key_pair.pub")
}
