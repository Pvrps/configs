{pkgs, ...}: {
  users.users.root.hashedPassword = "!"; # Disable root password
  users.users = {
    purps = {
      #hashedPasswordFile = "/persist/password";
      defaultPassword = "password";
      isNormalUser = true;
      shell = pkgs.nushell;
      extraGroups = [
        "networkmanager"
        "wheel"
        "disk"
        "video"
        "input"
        "media"
      ];
    };
  };
}
