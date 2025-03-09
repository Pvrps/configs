{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkMerge mkOption types;

  cfg = config.sysc.disko.btrfs;
  impermanent = config.sysc.impermanence.enable;
in {
  options.sysc.disko.btrfs = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Use this disk layout.";
    };

    device = mkOption {
      type = with types; nullOr str;
      description = "The target device to install to.";
    };
  };

  config = mkIf cfg.enable {
    disko.devices.disk = {
      system = {
        type = "disk";
        device = cfg.device;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            esp = {
              size = "550M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults"];
              };
            };
            main = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = mkMerge [
                  {
                    "/root-blank" = {};
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                  }
                  (mkIf impermanent {
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                  })
                ];
              };
            };
          };
        };
      };
    };

    fileSystems = mkIf impermanent {
      "/nix".neededForBoot = true;
      "/persist".neededForBoot = true;
    };
  };
}
