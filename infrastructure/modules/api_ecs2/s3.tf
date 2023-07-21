resource "aws_s3_bucket" "this" {
  bucket = "${var.service_name}-codedeploy-spec"

}

resource "aws_s3_object" "appspec_yaml" {
  bucket  = aws_s3_bucket.this.bucket
  key     = "appspec.yaml"
  content = <<-EOT
    version: 0.0
    Resources:
    - TargetService:
        Type: AWS::ECS::Service
        Properties:
            TaskDefinition: <TASK_DEFINITION>
            LoadBalancerInfo:
            ContainerName: "${var.service_name}"
            ContainerPort: ${var.container_port}
  EOT
}

resource "aws_s3_object" "taskdef_json" {
  bucket  = aws_s3_bucket.this.bucket
  key     = "taskdef.json"
  content = <<-EOT
    {
        "taskDefinitionArn": "${aws_ecs_task_definition.this.arn}",
        "containerDefinitions": [
            {
                "name": "${var.service_name}",
                "image": "<IMAGE1_NAME>",
                "portMappings": [
                    {
                        "containerPort": ${var.container_port},
                        "hostPort": 80,
                        "protocol": "tcp"
                    }
                ],
                "essential": true,
                "environment": [
                    {
                        "name": "PORT",
                        "value": "${var.container_port}"
                    },
                    {
                        "name": "APP_NAME",
                        "value": "${var.service_name}"
                    }
                ],
            }
        ],
        "family": "${var.service_name}",
        "networkMode": "awsvpc",
        "requiresCompatibilities": [
            "FARGATE"
        ],
        "cpu": "${aws_ecs_task_definition.this.cpu}",
        "memory": "${aws_ecs_task_definition.this.memory}",
    }
  EOT
}
