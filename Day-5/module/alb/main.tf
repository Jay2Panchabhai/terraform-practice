resource "aws_lb_target_group" "tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "my-target-group"
  }
}

resource "aws_lb" "my_lb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.sg_id]

  subnets = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  tags = {
    Name = "my-alb"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.my_lb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}