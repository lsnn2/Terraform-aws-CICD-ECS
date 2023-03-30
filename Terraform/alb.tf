module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "${var.stack}-alb"

  load_balancer_type = "application"

  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.alb-sg.id]

  target_groups = [
    {
      name_prefix      = "${var.stack}-tgrp"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "ip"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

output "alb_address" {
  value = module.alb.lb_dns_name
}

