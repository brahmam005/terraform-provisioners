resource "aws_instance" "web" {
  ami           = "ami-0f3c7d07486cad139" #devops-practice
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-all.id]

  tags = {
    Name = "provisioner"
  }


 provisioner "local-exec" {
    command = "echo this will execute  while creation of file you can trigger while other systems like email and sending alerts" 
      }


 provisioner "local-exec" {
    command = "echo  the server IP address is ${self.private_ip} > inventory" # self = aws_instance web
      }

  # provisioner "local-exec" {
  #   command = "ansible-playbook -i inventory web.yaml" 
  # }


 provisioner "local-exec" {
    when = destroy
    command = "echo this will execute  while destroy of file you can trigger while other systems likwhen = destroye email and sending alerts" 
    
      }


  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip

  }

   provisioner "remote-exec" {
    inline = [
      "echo 'this is for remote-exec'> /tmp/remote.txt",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx"
    ] 
  }

}
  resource "aws_security_group" "roboshop-all" { #this is terraform name, for terraform reference only
    name        = "provisoners" # this is for AWS
   

    ingress {
        description      = "Allow All ports"
        from_port        = 22 # 0 means all ports
        to_port          = 22 
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }


    ingress {
        description      = "Allow All ports"
        from_port        = 80 # 0 means all ports
        to_port          = 80 
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        #ipv6_cidr_blocks = ["::/0"]
    }
  
     tags = {
        Name = "provisioners"
    }
  }