terraform {
  required_providers {
    
    local = {
      source = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "terraform_key" {
    key_name = "terraform-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
    ami = "ami-0b6c6ebed2801a5cb"
    instance_type = "t2.micro"
    key_name = aws_key_pair.terraform_key.key_name

    tags = {
        Name = "Ansible-web-server"
    }
}

resource "local_file" "ansible_inventory" {

  content = templatefile("${path.module}/inventory.tpl", {
    public_ip = aws_instance.web.public_ip
  })

  filename = "../ansible/inventory"
}


