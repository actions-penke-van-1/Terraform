resource "aws_instance" "terraforma" {
  count = length(var.instances)  #inbuilt functions
  ami           = var.ami_id #RHEL-9-DevOps-Practice Redhat-9-DevOps-Practice -ami-0220d79f3f480ecf5
  instance_type = var.environemnt == "dev" ? "t3.micro" : "t3.medium"
  # instance_type = var.instance_typo
  vpc_security_group_ids = [aws_security_group.allow_all_tf.id]

  tags = {
    Name      = var.instances[count.index]
    Terraform = true
  }
}

resource "aws_security_group" "allow_all_tf" {
  name        = var.sg_name
  description = "Terr--- Managed "

  egress {
    from_port   = var.egress_from_port #opening all ports
    to_port     = var.egress_to_port
    protocol    = "-1"     #all protocols
    cidr_blocks = var.cidr #internet

  }

  ingress {
    from_port   = var.ingress_from_port #opening all ports
    to_port     = var.ingress_to_port
    protocol    = "-1"     #all protocols
    cidr_blocks = var.cidr #internet

  }

  tags = {
    Name = "allow-all-terraform"
  }
  lifecycle {
    ignore_changes = [description]
  }
}
