resource "aws_ssm_parameter" "fluent_bit_config" {
  name  = "meltano-fluent-bit-config"
  type  = "String"
  value = filebase64("./files/fluent-bit/fluent-bit.conf")
}

resource "aws_ssm_parameter" "fluent_bit_parsers_config" {
  name  = "meltano-fluent-bit-parsers-config"
  type  = "String"
  value = filebase64("./files/fluent-bit/parsers.conf")
}
