{ config, lib, pkgs, ... }:

let

in
with lib;
{

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware = {
    graphics.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    swww
    kitty
    rofi-wayland
    kdePackages.dolphin
  ];

  environment.sessionVariables = {
    WLR_DRM_NO_ATOMIC = "1";
  };

}
