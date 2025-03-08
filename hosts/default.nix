{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit user inputs self;};
    homeImports = import "${self}/home/profiles";
    user = "purps";
  in {
    # Desktop
    loki = nixosSystem {
      inherit specialArgs;
      modules = [
        {networking.hostName = "loki";}
        ./loki

        {
          home-manager = {
            users.${user}.imports = homeImports.loki;
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };

    # Add more hosts here..
  };
}
