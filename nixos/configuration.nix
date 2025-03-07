{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
      ./gaming.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      auto-optimise-store = true;
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };
  boot.loader.timeout = 3;

  boot.kernelParams = [ "quiet" ];

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

  system.stateVersion = "24.11";
}
