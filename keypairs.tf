resource "aws_key_pair" "cpwi_key" {
  key_name   = "cpwi"
  public_key = "${file("keypairs/keypair.pub")}"
}
