variable "prefix" {
  default = "csm-test-vm"
}

variable "location" {
  default = "West Europe"
}

variable "vm_size" {
  default = "Standard_DS1_v2"
}

variable "admin_username" {
  default = "csm"
}

variable "admin_password" {
  default = "Password1234"
}

variable "vm_environment_tag" {
  default = "csm-test-vm"
}

variable subnet_name {
  default = "test_its_subnet"
}

variable resource_group_name {
  default = "TEST_ITS_NetworkInfrastructure"
}

variable virtual_network_name {
  default = "TEST_ITS_VNET"
}
