{
  description = "FHS env for Android kernel build";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      apps.${system}.fhs = {
        type = "app";
        program = "${
            pkgs.buildFHSEnv {
              name = "android-kernel-fhs";

              targetPkgs = pkgs:
                (with pkgs; [
                  gcc
                  clang
                  bash
                  coreutils
                  gnumake
                  git
                  bc
                  bison
                  flex
                  perl
                  python3
                  zlib
                  zlib.dev
                  openssl
                  openssl.dev
                  pkg-config
                  ncurses
                  rsync
                  unzip
                  zip
                  cpio
                  elfutils
                  pahole
                ]);

              runScript = "bash";
            }
          }/bin/android-kernel-fhs";
      };
    };
}

