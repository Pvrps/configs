{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.firefox;
in {
  options.sysc.firefox = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable firefox.";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      policies = {
        DisablePocket = true;
        DisplayBookmarksToolbar = true;
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
          SponsoredPocket = false;
          SponsoredTopSites = false;
        };
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        ExtensionSettings = {
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          "firefox@ghostery.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };

      profiles = {
        Personal = {
          id = 0;

          search = {
            force = true;
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = ["@np"];
                  }
                ];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = ["@no"];
                  }
                ];
              };
            };
          };

          bookmarks = [
            {
              name = "Toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "Services";
                  bookmarks = [

                  ];
                }
                {
                  name = "Development";
                  bookmarks = [
                    {
                      name = "Web";
                      bookmarks = [

                      ];
                    }
                    {
                      name = "Nix";
                      bookmarks = [

                      ];
                    }
                    {

                    }
                  ];
                }
                {
                  name = "Radio";
                  bookmarks = [

                  ];
                }
              ];
            }
            {
              name = "Entertainment";
              bookmarks = [
                {
                  name = "YouTube";
                  url = "https://youtube.com/";
                }
                {
                  name = "Twitch";
                  url = "https://twitch.tv/";
                }
              ];
            }
          ];
        };
      };
    };

    home = {
      sessionVariables.BROWSER = "firefox";
      persistence."/persist/home/purps" = {
        directories = [
          ".mozilla/firefox"
        ];
      };
    };
  };
}
