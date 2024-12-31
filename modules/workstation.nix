{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;

  zig = callPackage (import ../extra-pkgs/zig) { };
in
{
  config = {

    home.sessionVariables = {
      RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
      CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    };

    home.sessionPath = [ "$CARGO_HOME/bin" ];

    home.packages = (
      with pkgs;
      [
        just
        wabt
        wasmtime
        nodejs.pkgs.typescript-language-server
        nil
        nixfmt-rfc-style
        binaryen
        clang-tools
        rustup
        brotli
        cmake
        simple-http-server
        nushell
        jwt-cli
      ]
      ++ [
        zig.zig
        zig.zls
      ]
    );
  };
}
