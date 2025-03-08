{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.systemd-boot;
  impermanent = config.sysc.impermanence.enable;
in {
  options.sysc.systemd-boot = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use systemd-boot.";
    };

    limit = mkOption {
      type = types.int;
      default = 16;
      description = "Configuration limit for boot list (decrease if EFI is out of storage).";
    };
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = cfg.limit;
    };

    systemd.tmpfiles.rules = mkIf impermanent [
      "d /persist/home/ 0777 root root -"
      "d /persist/home/purps 0700 purps users -"
    ];
  };
}
