{
  flake.templates = rec {
    parts = {
      path = ./parts;
      description = "Flake-parts based flake with support for linux";
    };

    default = parts;
  };
}
