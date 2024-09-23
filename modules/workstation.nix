{
  config,
  pkgs,
  lib,
  fenix-pkgs,
  ...
}:
let
  inherit (pkgs) callPackage system;
  ollama = callPackage (import ../extra-pkgs/ollama.nix) { };
  fenix = fenix-pkgs.packages.${system};
in
{
  config = {

    home.packages =
      (with pkgs; [
        just
        ffmpeg
        wabt
        wasmtime
        nodejs.pkgs.typescript-language-server
        nil
        nixfmt-rfc-style
        binaryen
        clang-tools
      ])
      ++ (with pkgs; [
        (fenix.stable.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ])
        fenix.targets.wasm32-unknown-unknown.stable.rust-std
        fenix.targets.wasm32-wasi.stable.rust-std
        rust-analyzer
      ])
      ++ [ ollama ];
    programs.yt-dlp.enable = true;
  };
}
