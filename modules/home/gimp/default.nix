{pkgs, ...}: {
  home = {
    packages = with pkgs; [gimp-with-plugins];
    persistence."/persist/home/purps".directories = [
      ".config/GIMP"
      ".cache/gimp"
    ];
  };
}
