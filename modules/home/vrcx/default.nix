{pkgs, ...}: {
  home = {
    packages = with pkgs; [vrcx];
    persistence."/persist/home/purps".directories = [
      ".config/VRCX"
    ];
  };
}
