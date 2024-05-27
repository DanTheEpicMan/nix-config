#NixOS Flake
{
 description = "A simple flake";

 inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    #stylix.url = "github:danth/stylix";

    home-manager = { #NOTE: may want to change to standalong as to not rebuild every time you install a home-manager package
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs"; #Will use the version specified in eviroment not flake.lock
    };
 };
 
 outputs = {self, nixpkgs, ... }@inputs: #@inputs makes it get self and nixpkgs from inputs, allows for access
 let 
   system = "x86_64-linux";
   pkgs = import.nixpkgs {
     inherit system; #allows for system to be used
     config = {
       allowUnfree = true;
     };
   };
 in
 {

  nixosConfigurations = {
    dan = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; }; #inherit allows for use in config.nix

      modules = [
        ./configuration.nix
      ];
    };
  };
 };

}