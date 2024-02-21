# Copyright (c) Timo Pallach
# SPDX-License-Identifier: BSD-2-Clause

build {
  sources = ["source.vmware-iso.alpine"]
}

source "vmware-iso" "alpine" {
  iso_url           = "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-standard-3.19.1-x86_64.iso"
  iso_checksum      = "file:https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-standard-3.19.1-x86_64.iso.sha256"
  cpus              = "2"
  memory            = "1024"
  disk_size         = "16384"
  communicator      = "ssh"
  ssh_password      = "root"
  ssh_username      = "root"
  shutdown_command  = "poweroff"
  vm_name           = "alpine"
  boot_command      = [
    "<wait5s>",
  ]
}
build {
  sources = [
    "sources.vmware-iso.alpine",
  ]
  provisioner "shell" {
    inline = ["exit 0"]
  }
}
