{pkgs, ...}: {
  home = {
    packages = [pkgs.aseprite];
    persistence."/persist/home/purps".directories = [".config/aseprite"];
  };
}
