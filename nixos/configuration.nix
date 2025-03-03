{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /mnt
    mount -o subvol=/ /dev/mapper/crypted /mnt
    btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
      echo "Deleting /$subvolume subvolume"
      btrfs subvolume delete "/mnt/$subvolume"
    done &&
    echo "Deleting /root subvolume" &&
    btrfs subvolume delete /mnt/root &&
    echo "Restoring blank /root subvolume" &&
    btrfs subvolume snapshot /mnt/root-blank /mnt/root &&
    umount /mnt
  '';

  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -"
    "d /persist/home/purps 0700 purps users -"
  ];

  users.users."purps" = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = ["wheel"];
  };
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Canada/Eastern";

  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    wget
  ];

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "purps" = import ./home.nix;
    };
  };

  system.stateVersion = "24.11";
}
