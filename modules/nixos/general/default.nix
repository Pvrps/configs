{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.general;
in {
  options.sysc.general = {
    timezone = mkOption {
      type = types.str;
      default = "Canada/Eastern";
      description = "Target timezone to use.";
    };
  };

  config = {
    time.timeZone = cfg.timezone;
  };
}
