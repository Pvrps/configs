{pkgs, ...}: {
  home = {
    packages = with pkgs; [spotify-player];

    persistence."/persist/home/purps".directories = [
      ".config/spotify-player"
      ".cache/spotify-player"
    ];
  };
}
