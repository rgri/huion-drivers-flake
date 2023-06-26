{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    deb.url = "file:///home/shortcut/git/huion-drivers-flake/driver.deb";
    deb.flake = false;
  };
  outputs = { self, ... }@inp:
    let
      pkgs = inp.nixpkgs.legacyPackages.x86_64-linux;
      buildStuff = with pkgs; [
        xorg.libXrandr.dev
        robo3t.out
        vial.out
        libusb1.out

        libsForQt5.qt3d.dev
        libsForQt5.qt5.qtgamepad.dev
        libsForQt5.qt5.qtvirtualkeyboard.dev
        qt5.qtbase.dev
        autoPatchelfHook
        dpkg
      ];
    in with pkgs; {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = buildStuff;
        shellHook = "echo 'you're in a shell";
      };
      huionDriver = stdenv.mkDerivation {
        name = "Huion Kamvas Driver";
        version = "???";
        src = inp.deb;
        out = src;
        unpackPhase = "true";
        dontWrapQtApps = "true";
        buildInputs = buildStuff;
        nativeBuildInputs = buildStuff;
        installPhase = ''
          mkdir -p $out
          dpkg -x $src $out
        '';
      };
    };
}
