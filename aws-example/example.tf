# adding a comment to run apply from terraform cloud
provider "aws" {
    #profile = "naeem"
    region = var.region
}

resource "aws_instance" "example" {
    ami = var.amis[var.region]
    instance_type = "t2.micro"

    provisioner "local-exec" {
        command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
    }
}

resource "aws_eip" "eip" {
    vpc = true
    instance = aws_instance.example.id
}
output "ip" {
  value = aws_instance.example.public_ip
}