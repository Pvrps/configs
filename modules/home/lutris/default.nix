{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.lutris;
in {
  options.sysc.lutris = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Lutris.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lutris-free
    ];

    home.persistence."/persist/home/purps".directories = [
      
    ];
  };
}
