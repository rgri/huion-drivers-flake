{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    deb.url = ./driver.deb;
    deb.flake = false;
  };
  outputs = { self, ... }@inp:
    let
      pkgs = inp.nixpkgs.legacyPackages.x86_64-linux;
      buildStuff = [ ];
    in with {
      inherit pkgs;
      inherit inp;
    }; {
      devShells.x86_64-linux.default = mkShell {
        packages = buildStuff;
        shellHook = "echo 'you're in a shell";
      };
      huionDriver = pkgs.mkDerivation {
        name = "Huion Kamvas Driver";
        version = "1.0";
        src = ./.;
        out = src;
        buildInputs = buildStuff;
        nativeBuildInputs = buildstuff;

      };
    };
}