output "secret" {
  value = "${aws_iam_access_key.s3_cpwi.encrypted_secret}"
}
