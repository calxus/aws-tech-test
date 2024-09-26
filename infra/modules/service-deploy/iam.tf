resource "aws_iam_role" "poc" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.poc_assume_role.json
}

data "aws_iam_policy_document" "poc_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "poc_pull_image" {
  name   = "${var.name}-pull-image"
  role   = aws_iam_role.poc.id
  policy = data.aws_iam_policy_document.poc_pull_image.json
}

data "aws_iam_policy_document" "poc_pull_image" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::prod-region-starport-layer-bucket/*"
    ]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "*"
    ]
  }
}