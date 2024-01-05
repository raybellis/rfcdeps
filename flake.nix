{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = pkgs.mkShell {
              nativeBuildInputs = [
                pkgs.wget
                (pkgs.perl.withPackages (pp: [
                  pp.XMLSimple
                ]))
                pkgs.graphviz
              ];
            };
          });
    };
}
