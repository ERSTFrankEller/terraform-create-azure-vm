data "azurerm_resource_group" "main" {
  name = "${var.resource_group}"
}

data "azurerm_subnet" "main" {
  name = "${var.subnet_name}"
  resource_group_name = "${var.resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
}

resource "azurerm_network_interface" "main" {
  ip_configuration {
    name = "ipconfig1"
    private_ip_address_allocation = "dynamic"
    subnet_id = "${data.azurerm_subnet.main.id}"
  }
  location = "${data.azurerm_resource_group.main.location}"
  name = "${var.prefix}-nic"
  resource_group_name = "${data.azurerm_resource_group.main.name}"
}

resource "random_string" "password" {
  length = 32
}

resource "azurerm_virtual_machine" "main" {
  location = "${data.azurerm_resource_group.main.location}"
  name = "${var.prefix}"
  network_interface_ids = [
    "${azurerm_network_interface.main.id}"]
  resource_group_name = "${data.azurerm_resource_group.main.name}"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    create_option = "FromImage"
    name = "${var.prefix}-osdisk"
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }
  vm_size = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "16.04-LTS"
    version = "latest"
  }

  os_profile {
    computer_name = "${var.prefix}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "${var.vm_environment_tag}"
  }
}