{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence 
  ];

  home.stateVersion = "24.11";

  home.persistence."/persist/home/purps" = {
    directories = [
      
    ];
    files = [
      
    ];
    allowOther = true;
  };

  home.packages = with pkgs; [
    fish
    helix
    git
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    FLAKE = "/etc/nixos";
  };

  home.shellAliases = {
    la = "ls -la";

    nixrebuild = "sudo nixos-rebuild --upgrade switch --flake path:/etc/nixos#default --impure";
    nixrebuild-boot = "sudo nixos-rebuild boot --flake path:/etc/nixos#default --impure";
    nixflake-update = "sudo nix flake update --flake path:/etc/nixos#default";
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      
    '';
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    userName = "purps";
    userEmail = "github@purps.ca";

    extraConfig = {
      core.editor = "hx";
    };
  };
  
}
