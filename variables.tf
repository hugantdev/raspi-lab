variable "raspberry_pi_ip" {
  default = "192.168.1.49"
}

variable "raspberry_pi_user" {
  # The user used in ssh connection must be able to run sudo without password.
  # So the user must be in sudoers file.
  # You have to execute the following command in the raspberry:
  # %> sudo visudo
  # Add the following line at the end of the file:
  # sonia   ALL=(ALL:ALL) NOPASSWD:ALL
  default = "sonia"
}

variable "raspberry_pi_private_key" {
  default = "~/.ssh/id_raspi"
}
