{ stdenv, pkgs ? import <nixpkgs> { } }:
let

  version = "15.0.0.89.202205241352";

  src = ./HuionTablet_v15.0.0.89.202205241352.x86_64.deb;

in with pkgs;
stdenv.mkDerivation {
  name = "HuionTablet_v15.0.0.89.202205241352.x86_64";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = with pkgs; [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
    libsForQt5.qt5.wrapQtAppsHook
    xorg.libXrandr
    libusb1
    libsForQt5.qt5.qt3d
    libsForQt5.qt5.qtgamepad
    libsForQt5.qt5.qtvirtualkeyboard
    libsForQt5.qt5.qtxmlpatterns
    libsForQt5.qt5.qtremoteobjects
  ];

  # Required at running time
  buildInputs = with pkgs; [ libsForQt5.qt5.qtbase glibc gcc-unwrapped ];

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg-deb -x $src $out
    chmod 755 $out
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "HuionTablet";
      desktopName = "HuionTablet";
      comment = "Huion driver";
      exec = "/usr/lib/huiontablet.sh";
      icon = "huiontablet.png";
      categories = [ "Application" "Utility" ];
      startupNotify = true;
    })
  ];

  meta = with pkgs.lib; {
    description = "Wolframscript";
    homepage = "https://www.wolfram.com/wolframscript/";
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
