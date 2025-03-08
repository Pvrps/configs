{
  lib,
  config,
  pkgs,
  ...
} @ args: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.helix;
in {
  options.sysc.helix = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable helix.";
    };
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      languages = import ./languages.nix args;
      settings = import ./settings.nix args;

      extraPackages = with pkgs;
        [
          nil
        ]
        ++ (with nodePackages; [
          typescript-language-server
          vscode-langservers-extracted
        ]);
    };
  };
}
