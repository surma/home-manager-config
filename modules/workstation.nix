{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;

  zig = callPackage (import ../extra-pkgs/zig) { };
  llvm_19 = callPackage (import ../extra-pkgs/llvm_19) { };
in
{
  config = {

    home.sessionVariables = {
      RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
      CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    };

    home.sessionPath = [ "$CARGO_HOME/bin" ];

    home.packages =
      (with pkgs; [
        just
        wabt
        wasmtime
        nodejs.pkgs.typescript-language-server
        pnpm_9
        nil
        nixfmt-rfc-style
        binaryen
        rustup
        brotli
        cmake
        simple-http-server
        nushell
        jwt-cli
        podman
        podman-compose
        graphviz
      ])
      ++ [
        zig.zig
        zig.zls
      ]
      ++ [
        (callPackage (import ../extra-pkgs/aider) { })
      ];
    # Shadowing MacOS's clang breaks all kind of shit
    # ++ (
    #   with llvm_19;
    #   (lib.lists.map lib.getDev [
    #     lld
    #     llvm
    #     libllvm
    #     libclang
    #     clang
    #   ])
    # );
  };
}
