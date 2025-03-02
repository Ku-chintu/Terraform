############## Application Load Balancer for FE ################
resource "aws_lb" "fe_alb" {
  name               = "fe-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "fe-alb"
  }
}

resource "aws_lb_target_group" "fe_tg" {
  name     = "fe-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "fe_listener" {
  load_balancer_arn = aws_lb.fe_alb.arn
  port               = 80
  protocol           = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fe_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "fe_tg_attachment" {
  target_group_arn = aws_lb_target_group.fe_tg.arn
  target_id        = aws_instance.FE-web-ec2.id
  port             = 80
}