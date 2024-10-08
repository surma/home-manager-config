{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
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
      ]
    );
  };
}
