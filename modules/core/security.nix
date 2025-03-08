_: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam = {
      services = {
        sudo.u2fAuth = true;
        hyprlock.text = "auth include login";
      };
      u2f = {
        enable = true;
        settings.cue = true;
      };
    };
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
      execWheelOnly = true;
    };
  };

  programs.yubikey-touch-detector.enable = true;

  boot = {
    kernelModules = ["tcp_bbr"];
  };
}
