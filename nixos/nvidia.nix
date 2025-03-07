{ config, lib, pkgs, ... }:

{
  boot = {
    kernelModules = [ "nvidia" ];
    extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;
      modesetting.enable = true;
      open = true;
      forceFullCompositionPipeline = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };
  };

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option "medamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      '';
    };
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
