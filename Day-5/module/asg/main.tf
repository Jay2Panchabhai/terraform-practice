resource "aws_launch_template" "lt" {

  name_prefix = "my-lt-"

  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.sg_id]

  user_data = base64encode(
    file("${path.module}/user_data.sh")
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "asg-instance"
    }
  }
}

resource "aws_autoscaling_group" "asg" {

  name = "my-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}