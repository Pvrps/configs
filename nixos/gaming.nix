{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept_responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  services.pulseaudio = {
    support32Bit = true;
    extraConfig = ''
      load-module module-udev-detect tsched=0
      load-module module-switch-on-connect
    '';
  };

}
