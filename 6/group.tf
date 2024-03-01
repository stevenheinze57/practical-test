
resource "aws_iam_group" "crypto_dev" {
  name = "crypto_dev"
  path = "/users/"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.crypto_dev.name 
  policy_arn = aws_iam_policy.crypto_dev_assume_role.id 
}
