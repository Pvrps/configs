{pkgs, ...}: {
  home = {
    packages = [pkgs.osu-lazer];
    persistence."/persist/home/purps".directories = [".local/share/osu"];
  };
}
