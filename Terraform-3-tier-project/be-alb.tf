############## Application Load Balancer for BE ################
resource "aws_lb" "be_alb" {
  name               = "be-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project_sg.id]
  subnets            = [aws_subnet.fe_subnet_1.id, aws_subnet.fe_subnet_2.id]

  tags = {
    Name = "be-alb"
  }
}

resource "aws_lb_target_group" "be_tg" {
  name     = "be-tg"
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

resource "aws_lb_listener" "be_listener" {
  load_balancer_arn = aws_lb.be_alb.arn
  port               = 80
  protocol           = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.be_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "be_tg_attachment" {
  target_group_arn = aws_lb_target_group.be_tg.arn
  target_id        = aws_instance.BE-app-ec2.id
  port             = 80
}
