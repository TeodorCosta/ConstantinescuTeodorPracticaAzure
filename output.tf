output "pass1" {
  value =  random_password.password.0.result
  sensitive = true
}
output "pass2" {
  value =  random_password.password.1.result
  sensitive = true
}
output "pass3" {
  value =  random_password.password.2.result
  sensitive = true
}
output "vm1_ip" {
  value = azurerm_public_ip.pip[0].ip_address
}
output "vm2_ip" {
  value = azurerm_public_ip.pip[1].ip_address
}
output "vm3_ip" {
  value = azurerm_public_ip.pip[2].ip_address
}
output "acr_admin_password" {
  value = data.azurerm_container_registry.container_registry.admin_password
}
output "acr_admin_username" {
  value = data.azurerm_container_registry.container_registry.admin_username
  
}
output "acr_login_server" {
  value = data.azurerm_container_registry.container_registry.login_server
  
}
output "nginx_url" {
  description = "URL nginx "
  value = [for ip in azurerm_public_ip.pip[*].ip_address : "http://${ip}"]
 }