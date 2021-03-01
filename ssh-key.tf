resource "tls_private_key" "main_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}