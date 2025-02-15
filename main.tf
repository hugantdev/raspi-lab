
resource "terraform_data" "install_microk8s" {
  # Configure the connection to the Raspberry Pi
  connection {
    type        = "ssh"
    user        = var.raspberry_pi_user
    private_key = file(var.raspberry_pi_private_key)
    host        = var.raspberry_pi_ip
  }

  provisioner "remote-exec" {
    # Install microk8s
    inline = [
      "sudo snap install microk8s --classic --channel=1.32",
      "sudo usermod -a -G microk8s $USER",
      "mkdir -p ~/.kube",
      "chmod 0700 ~/.kube",
    ]
  }
}
