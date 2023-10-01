{ pkgs ? import <nixpkgs> { }, }:
let
  wrapQtAppsHook = pkgs.libsForQt5.qt5.wrapQtAppsHook;
  qtbase = pkgs.libsForQt5.qt5.qtbase;
  libXrandr = pkgs.xorg.libXrandr;
  libusb1 = pkgs.libusb1;
  qt3d = pkgs.libsForQt5.qt5.qt3d;
  qtgamepad = pkgs.libsForQt5.qt5.qtgamepad;
  qtvirtualkeyboard = pkgs.libsForQt5.qt5.qtvirtualkeyboard;
  qtxmlpatterns = pkgs.libsForQt5.qt5.qtxmlpatterns;
  qtremoteobjects = pkgs.libsForQt5.qt5.qtremoteobjects;
in pkgs.callPackage ./derivation.nix {
  inherit wrapQtAppsHook;
  inherit qtbase;
  inherit libXrandr;
  inherit libusb1;
  inherit qt3d;
  inherit qtgamepad;
  inherit qtvirtualkeyboard;
  inherit qtxmlpatterns;
  inherit qtremoteobjects;
}
