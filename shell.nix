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
    mesa
    llvmPackages.llvm
    llvmPackages.clang
    llvmPackages.lld
    openssl
    ripgrep
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    weston
    xorg.xauth
    xorg.libX11
    xdotool
    xorg.xorgserver
    xvfb-run
  ];

  shellHook = ''
    export ABLA_GRAPHICS_DEV_SHELL=1
    export ABLA_GRAPHICS_LVP_ICD="${pkgs.mesa}/share/vulkan/icd.d/lvp_icd.x86_64.json"
    export ABLA_GRAPHICS_EGL_VENDOR="${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
    export ABLA_GRAPHICS_DRI="${pkgs.mesa}/lib/dri"
    # mkShell's synthetic $out/lib RUNPATH disappears after the shell exits.
    # Preserve the actual graphics loader locations so an Abla executable built
    # here can be launched directly without inheriting LD_LIBRARY_PATH.
    export NIX_LDFLAGS="$NIX_LDFLAGS -rpath ${pkgs.vulkan-loader}/lib -rpath ${pkgs.libglvnd}/lib -rpath ${pkgs.mesa}/lib -rpath ${pkgs.xorg.libX11}/lib"
    export LD_LIBRARY_PATH="${pkgs.openssl.out}/lib:${pkgs.vulkan-loader}/lib:${pkgs.libglvnd}/lib:${pkgs.mesa}/lib:${pkgs.xorg.libX11}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  '';
}
