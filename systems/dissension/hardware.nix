{inputs, ...}: {
  imports = with inputs.hardware.nixosModules; [
    common-pc-ssd
    common-cpu-amd
    common-gpu-nvidia-nonprime
  ];

  sysc = {
    disko.btrfs.device = "/dev/nvme0n1";
    monitors = [
      {
        # Center monitor
        name = "DP-1";
        width = 2560;
        height = 1440;
        x = 0;
        refreshRate = 144;
        workspace = "1";
      }
      {
        # Right monitor
        name = "DP-2";
        width = 2560;
        height = 1440;
        x = 2560;
        refreshRate = 144;
        workspace = "2";
      }
    ];
    nvidia = {
      enable = true;
      enableOpen = true;
    };
  };
  hardware = {
    steam-hardware.enable = true;
    keyboard.qmk.enable = true;
  };

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-amd"];
}
