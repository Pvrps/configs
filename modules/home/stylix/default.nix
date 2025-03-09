{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.stylix.homeManagerModules) stylix;
in {
  imports = [stylix];

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;

    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";    

    base16Scheme = {
      system = "base16";
      name = "selenized-black";
      author = "Jan Warchol (https://github.com/jan-warchol/selenized) / adapted to base16 by ali";
      variant = "dark";

      palette = {
        base00 = "181818";
        base01 = "252525";
        base02 = "3b3b3b";
        base03 = "777777";
        base04 = "777777";
        base05 = "b9b9b9";
        base06 = "dedede";
        base07 = "dedede";
        base08 = "ed4a46";
        base09 = "e67f43";
        base0A = "dbb32d";
        base0B = "70b433";
        base0C = "3fc5b7";
        base0D = "368aeb";
        base0E = "a580e2";
        base0F = "eb6eb7";
      };
    };

    polarity = "dark";

    opacity = {
      desktop = 0.8;
      terminal = 0.8;
      popups = 0.6;
    };

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };

    fonts = {
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      monospace = {
        package = pkgs.geist-mono-nerd-font;
        name = "GeistMono NFM";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };

    targets.vscode.enable = false;
  };

  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.symbols-only
  ];
}
