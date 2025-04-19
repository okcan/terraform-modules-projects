resource "aws_sfn_state_machine" "my_state_machine" {
  name     = "my-state-machine"
  role_arn = aws_iam_role.my_sfn_role.arn

  definition = <<EOF
  {
    "Comment": "A Hello World example of the Amazon States Language using a Pass state",
    "StartAt": "HelloWorld",
    "States": {
      "HelloWorld": {
        "Type": "Pass",
        "Result": "Hello, World!",
        "End": true
      }
    }
  }
  EOF
}

