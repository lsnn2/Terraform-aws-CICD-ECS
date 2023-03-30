
data "aws_ssm_parameter" "dbpassword" {
  name = "dbpassword"
#   with_decryption = true
}