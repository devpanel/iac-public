resource "tls_private_key" "main_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "random_string" "master_key" {
  length  = "32"
  special = false
  lower   = true
  number  = true
  upper   = true
}