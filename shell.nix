{ pkgs ? import (builtins.fetchTarball {
    name = "nixpkgs-5e2a59a5b1a82f89f2c7e598302a9cacebb72a67";
    url = "https://github.com/NixOS/nixpkgs/archive/5e2a59a5b1a82f89f2c7e598302a9cacebb72a67.tar.gz";
    sha256 = "02rf59xj2v1ml7v35x4j64ax1fb7xx96ld7va6rifyxazmwsr4rb";
  }) {} }:

pkgs.mkShell {
  packages = with pkgs; [
    gcc
    gnumake
    libglvnd
    llvmPackages.llvm
    llvmPackages.clang
    llvmPackages.lld
    openssl
    ripgrep
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    xorg.xauth
    xorg.libX11
    xorg.xorgserver
    xvfb-run
  ];

  shellHook = ''
    export ABLA_GRAPHICS_DEV_SHELL=1
    export LD_LIBRARY_PATH="${pkgs.openssl.out}/lib:${pkgs.vulkan-loader}/lib:${pkgs.libglvnd}/lib:${pkgs.xorg.libX11}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  '';
}
