
resource "aws_iam_user" "bitcoin" {
  name = "bitcoin"
  path = "/"
}

resource "aws_iam_user_group_membership" "bitcoin_membership_crypto_dev" {
  user = aws_iam_user.bitcoin.name

  groups = [
    aws_iam_group.crypto_dev.name 
  ]
}
