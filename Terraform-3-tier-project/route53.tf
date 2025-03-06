############## Route 53 Configuration ################
resource "aws_route53_zone" "project_zone" {
  name = "kumarchintu.co.in"
}

resource "aws_route53_record" "fe_record" {
  zone_id = aws_route53_zone.project_zone.zone_id
  name    = "fe.kumarchintu.co.in"
  type    = "A"
  alias {
    name                   = aws_lb.fe_alb.dns_name
    zone_id                = aws_lb.fe_alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "be_record" {
  zone_id = aws_route53_zone.project_zone.zone_id
  name    = "be.kumarchintu.co.in"
  type    = "A"
  alias {
    name                   = aws_lb.be_alb.dns_name
    zone_id                = aws_lb.be_alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "rds_record" {
  zone_id = aws_route53_zone.project_zone.zone_id
  name    = "rds.kumarchintu.co.in"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.default.endpoint]
}