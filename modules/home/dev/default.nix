{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption optionals types;

  cfg = config.sysc.dev;
in {
  options.sysc.dev = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to set-up dev tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      [

      ]
      ++ (with pkgs; [
        cargo-watch
        file
        htop
        btop
        wget
        jq
        p7zip
        neofetch
        nodejs
        unzip
        usbutils
        zip
        gcc
      ])
      ++ (with pkgs.nodePackages; [
        yarn
        pnpm
      ]);
  };
}
