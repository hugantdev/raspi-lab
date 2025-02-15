# RaspberryPi as a Lab
## Requirements
### Hardware
- RaspberryPi 5
- 128 GB memory card
### Operating System
- Ubuntu Server 24
### Services
- SSH Server
### Access
- SSH access with private-key
* Key generation
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_raspi
```
* Copy key to the server
```bash
ssh-copy-id -i ~/.ssh/id_raspi <user>@<raspi-host>
```
## Configuration
The main component of this lab will be [MicroK8s](https://microk8s.io/), which will be installed on the RaspberryPi. To carry out its installation, we will use [Terraform](https://developer.hashicorp.com/terraform/language).
### Files
- [providers.tf](providers.tf): Terraform provider configuration file to be used. In this case, the [null_provider](https://registry.terraform.io/providers/hashicorp/null/latest/docs) will be used to execute remote commands.
- [variables.tf](variables.tf): Variable definition file that will be used in the main Terraform file.
- [main.tf](main.tf): Main Terraform file where the resources to be created are defined. The resource will be a _script_ that will install MicroK8s on the RaspberryPi and will be a [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) type resource.
  - **connection**: Defines the SSH connection with the RaspberryPi.
  - **provisioners**: [remote-exec](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource#remote-exec). Defines the commands to be executed on the RaspberryPi.
### Preliminary Steps
Some of the commands to be executed remotely on the RaspberryPi require superuser permissions. To do this, passwordless access must be configured for the user used for the SSH connection. To do this, add the user to the _sudo_ group and configure passwordless access. Execute:
```bash
sudo visudo
```
And add the following line at the end of the file:
```bash
<user> ALL=(ALL:ALL) NOPASSWD: ALL
```
You can check that the user belongs to the _sudo_ group by executing:
```bash
ssh -i ~/.ssh/id_raspi <user>@<raspi-host> "sudo whoami"
```
### Execution
To execute the Terraform script, run:
```bash
terraform init
terraform apply
```
### Verification
At the end of the script execution, you can verify that MicroK8s has been installed correctly by executing:
```bash
ssh -i ~/.ssh/id_raspi <user>@<raspi-host> "microk8s status --wait-ready"
``` 
### Final Steps
For security, we will remove the user from the _sudo_ group on the RaspberryPi. To do this, execute:
```bash
sudo visudo
```
And delete the previously added line. To verify that the user no longer has superuser permissions, execute:
```bash
ssh -i ~/.ssh/id_raspi <user>@<raspi-host> "sudo whoami"
```



