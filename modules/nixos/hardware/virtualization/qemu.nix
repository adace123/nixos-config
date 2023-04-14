{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  virtualisation = {
    diskSize = 75000; # MB
    memorySize = 4096; # MB
    writableStoreUseTmpfs = false;
    graphics = true;

    # sharedDirectories = {
    #   nixos-config = {
    #     source = "/home/aaron/nixos-config";
    #     target = "/mnt/nixos-config";
    #   };
    # };

    forwardPorts = [
      {
        from = "host";
        host.port = 2222;
        guest.port = 22;
      }
    ];

    qemu.options = ["-display gtk,grab-on-hover=on"];
  };
}
