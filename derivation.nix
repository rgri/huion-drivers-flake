{ stdenv, qtbase, wrapQtAppsHook, dpkg, glibc, gcc-unwrapped, autoPatchelfHook
, makeDesktopItem, lib, libXrandr, libusb1, qt3d, qtgamepad, qtvirtualkeyboard
, qtxmlpatterns, qtremoteobjects }:
let

  version = "15.0.0.89.202205241352";

  src = ./HuionTablet_v15.0.0.89.202205241352.x86_64.deb;

in stdenv.mkDerivation {
  name = "HuionTablet_v15.0.0.89.202205241352.x86_64";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
    wrapQtAppsHook
    libXrandr
    libusb1
    qt3d
    qtgamepad
    qtvirtualkeyboard
    qtxmlpatterns
    qtremoteobjects
  ];

  # Required at running time
  buildInputs = [ qtbase glibc gcc-unwrapped ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/usr/lib $out
    rm -rf $out/usr
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "HuionTablet";
      desktopName = "HuionTablet";
      comment = "Huion driver";
      exec = "huiontablet.sh";
      icon = "huiontablet.png";
      categories = [ "Application" "Utility" ];
      startupNotify = true;
    })
  ];

  meta = with lib; {
    description = "Wolframscript";
    homepage = "https://www.wolfram.com/wolframscript/";
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
