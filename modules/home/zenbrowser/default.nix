{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.zenbrowser;
in {
  options.sysc.zenbrowser = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable zen-browser.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".twilight
    ];

    home.persistence."/persist/home/purps".directories = [
      ".zen"
    ];
  };
}
