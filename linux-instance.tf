
resource "azurerm_network_interface" "networkinterface" {
  name                = "demonic"
  location            = azurerm_resource_group.demoresourcegroup.location
  resource_group_name = azurerm_resource_group.demoresourcegroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demosubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.demopublicip.id
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = "linux-machine"
  resource_group_name             = azurerm_resource_group.demoresourcegroup.name
  location                        = azurerm_resource_group.demoresourcegroup.location
  size                            = "Standard_D2_V2"
  admin_username                  = var.username
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.networkinterface.id,
  ]

  admin_ssh_key {
    username   = var.username
     public_key = file("/home/weblogic/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "remote-exec" {
   inline = [
      "sudo apt-get update",
      "sudo apt-get install openjdk-17-jdk -y"
    ]

    connection {
      type        = "ssh"
      user        = var.username
      private_key = file("/home/weblogic/.ssh/id_rsa")
      host        = azurerm_public_ip.demopublicip.ip_address
      port        = 22
    }
  }
}




resource "null_resource" "run_ansible_playbook" {
  depends_on = [azurerm_linux_virtual_machine.linuxvm]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${azurerm_public_ip.demopublicip.ip_address},' playbook.yml --extra-vars='ansible_ssh_user=${var.username}' --private-key='/home/weblogic/.ssh/id_rsa' --become --become-user=root"
  }
}



