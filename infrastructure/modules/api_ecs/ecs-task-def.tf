resource "aws_ecs_task_definition" "this" {
  family                   = var.service_name
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  cpu                      = 2000
  memory                   = 1000 # TODO
  requires_compatibilities = ["FARGATE"]
  container_definitions    = <<DEFINITION
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
      "image": "<IMAGE1_NAME>",
      "name": "${var.service_name}",
      "essential": true
    }
]
DEFINITION
}
