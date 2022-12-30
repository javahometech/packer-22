packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "linux" {
  ami_name      = "learn-packer-linux-aws2"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami    = "ami-0a606d8395a538502"
  ssh_username = "ec2-user"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.linux"
  ]
  provisioner "shell" {
    inline = [
      "echo provisioning all the things",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
    ]
  }
}
