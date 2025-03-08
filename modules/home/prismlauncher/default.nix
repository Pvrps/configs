{pkgs, ...}: {
  home = {
    packages = with pkgs; [prismlauncher];
    persistence."/persist/home/purps".directories = [
      ".local/share/PrismLauncher"
    ];
  };
}
