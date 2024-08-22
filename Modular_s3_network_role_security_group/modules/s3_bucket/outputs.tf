
output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "iam_role_arn" {
  value = aws_iam_role.s3_role.arn
}

output "iam_policy_arn" {
  value = aws_iam_policy.s3_policy.arn
}

output "security_group_id" {
  value = aws_security_group.s3_security_group.id
}
