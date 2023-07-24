resource "aws_ecs_task_definition" "this" {
  family                   = "${var.service_name}-td-2"
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  # "nginx" is just a placeholder
  container_definitions = <<DEFINITION
[
   {
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": ${var.container_port}
        }
      ],
      "environment": [
        {
          "name": "PORT",
          "value": "${var.container_port}"
        },
        {
          "name" : "APP_NAME",
          "value": "${var.service_name}"
        }
      ],
      "image": "nginx",
      "name": "${var.service_name}",
      "essential": true
    }
]
DEFINITION

}
