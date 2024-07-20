resource "null_resource" "vm1_to_vm2_ping" {
  count = 2
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "azureuser"
      password = random_password.password[count.index].result
      host     = count.index == 0 ? azurerm_public_ip.pip[0].ip_address : azurerm_public_ip.pip[1].ip_address
    }

    inline = [
      "ping -c 4 ${count.index == 0 ? azurerm_public_ip.pip[1].ip_address : azurerm_public_ip.pip[0].ip_address}"
    ]
}
}