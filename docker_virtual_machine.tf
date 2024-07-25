resource "azurerm_virtual_machine" "DockerVm" {
  name                = "DockerVm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.nic.2.id
  ]
  vm_size             = "Standard_DS1_v2"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"
    admin_password = "Azurepass1"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  connection {
    type        = "ssh"
    user        = "azureuser"
    password    = "Azurepass1"
    host        = azurerm_public_ip.pip.2.ip_address
  }

  provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
    "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
    "echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable' | sudo tee /etc/apt/sources.list.d/docker.list",
    "sudo apt-get update",
    "sudo apt-get install -y docker-ce",
    "sudo systemctl start docker",
    "sudo systemctl enable docker",
    "echo ${data.azurerm_container_registry.container_registry.admin_password} | sudo docker login -u ${data.azurerm_container_registry.container_registry.admin_username} --password-stdin ${data.azurerm_container_registry.container_registry.login_server}",
    "sudo docker pull ${data.azurerm_container_registry.container_registry.login_server}/catalogapp3",
    "sudo docker run -d -p 80:80 ${data.azurerm_container_registry.container_registry.login_server}/catalogapp3"
  ]
}

}
