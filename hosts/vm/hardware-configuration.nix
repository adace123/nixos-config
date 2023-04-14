{...}: {
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "ohci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
    "virtio_blk"
    "virtio_pci"
  ];
}
