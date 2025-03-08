{pkgs, ...}: {
  home = {
    packages = with pkgs; [blender];
    persistence."/persist/home/purps".directories = [
      ".config/blender"
    ];
  };
}
