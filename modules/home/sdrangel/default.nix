{pkgs, ...}: {
  home = {
    packages = [pkgs.sdrangel];
    persistence."/persist/home/purps".directories = [".config/f4exb"];
  };
}
