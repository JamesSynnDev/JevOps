resource "aws_instance" "example" {
    ami = ""
    instance_type = "t2.micro"
    # 
    vpc_security_group_ids = [aws_security_group.instance.id]


    user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello" > index.html
                    nohup busybox httpd -f -p 8080 &
                    EOF

    tags = {
      name = "terraform-example"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}