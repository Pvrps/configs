{pkgs, ...}: {
  home = {
    packages = [pkgs.chatterino2];
    persistence."/persist/home/purps".directories = [
      ".local/share/chatterino"
    ];
  };
}
