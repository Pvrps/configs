{pkgs, ...}: {
  home = {
    packages = [pkgs.mepo];
    persistence."/persist/home/purps".directories = [
      ".cache/mepo"
    ];
  };
}
