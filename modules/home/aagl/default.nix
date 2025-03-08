{
  lib,
  osConfig,
  ...
}:
with lib; {
  config = mkIf osConfig.sysc.aagl.enable {
    home.persistence."/persist/home/purps".directories = [
      ".local/share/honkers-railway-launcher"
      ".local/share/sleepy-launcher"
      ".local/share/wavey-launcher"
    ];
  };
}
