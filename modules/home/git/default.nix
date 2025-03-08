{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.git;
in {
  options.sysc.git = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable git.";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      userName = "Purps";
      userEmail = "github@purps.ca";

      signing = {
        key = "";
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        credential.helper = "libsecret";
      };
    };
  };
}
