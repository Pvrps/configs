args: {
  flake = {
    homeManagerModules = import ./home args;
    nixosModules = import ./nixos args;
    sharedModules = import ./shared args;
  };
}
