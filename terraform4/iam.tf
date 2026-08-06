data "aws_iam_policy" "ssm_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "my_ssm_role" {
  name = "tf-rackula-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "my_ssm_attachment" {
  role       = aws_iam_role.my_ssm_role.name
  policy_arn = data.aws_iam_policy.ssm_core.arn
}

resource "aws_iam_instance_profile" "my_ssm_profile" {
  name = "tf-rackula-ssm-profile"
  role = aws_iam_role.my_ssm_role.name
}
