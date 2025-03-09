{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption optionals types;

  cfg = config.sysc.rustdesk;
in {
  options.sysc.rustdesk = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Rustdesk.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rustdesk ];
  };
}
