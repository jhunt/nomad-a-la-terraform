variable "nodes" {
  default = 3
}

variable "linode_token" {
  type = string
}

variable "authorized_keys" {
  type = list(string)
}

terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.linode_token 
}

resource "linode_instance" "nomad" {
  count  = var.nodes
  image  = "linode/ubuntu20.04"
  label  = "nomad${count.index}"
  group  = "nomad"
  region = "us-east"
  type   = "g6-nanode-1"

  private_ip = true

  authorized_keys = var.authorized_keys

  provisioner "file" {
    connection {
      host  = self.ip_address
      type  = "ssh"
      user  = "root"
      agent = "true"
    }

    source      = "files/nomad-me-up"
    destination = "/usr/local/bin/nomad-me-up"
  }

  provisioner "remote-exec" {
    connection {
      host  = self.ip_address
      type  = "ssh"
      user  = "root"
      agent = "true"
    }

    inline = [
      "/bin/sh /usr/local/bin/nomad-me-up dc1 node${count.index} ${var.nodes}"
    ]
  }
}
