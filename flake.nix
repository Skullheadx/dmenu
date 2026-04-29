{
  description = "flake for building dmenu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "dmenu";
        version = "5.4";
        src = ./.;

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = with pkgs; [
          libX11
          fontconfig
          libxinerama
          libxft
        ];
        makeFlags = [
          "PREFIX=$(out)"
          "CC:=$(CC)"
        ];

      };
    };
}
