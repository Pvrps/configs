{
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };

  home.persistence."/persist/home/purps".directories = [
    ".local/share/zoxide"
  ];
}
