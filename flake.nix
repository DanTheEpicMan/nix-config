{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.dan = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #config.allowUnfree = true;
      modules = [ ./configuration.nix ];
    };
  };
}
