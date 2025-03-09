{config, lib, pkgs, inputs, ...}:

{
  sysc = {
    libvirtd.enable = true;
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /mnt
    mount -o subvol=/ /dev/nvme0n1p3 /mnt
    btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
      btrfs subvolume delete "/mnt/$subvolume"
    done &&
    btrfs subvolume delete /mnt/root &&
    btrfs subvolume snapshot /mnt/root-blank /mnt/root &&
    umount /mnt
  '';

  system.stateVersion = "24.05";
}
