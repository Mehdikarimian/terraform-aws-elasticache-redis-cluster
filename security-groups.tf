# this security group for ecs - Traffic to the ECS cluster should only come from the ALB
locals {
  security_group_name = var.security_group_name == "" ? "${var.namespace}" : "${var.namespace}_${var.security_group_name}"
}

resource "aws_security_group" "redis-security-group" {
  name   = local.security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
