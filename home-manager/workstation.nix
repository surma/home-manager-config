{
  config,
  pkgs,
  ...
}:
let
  inherit (pkgs) callPackage;
in
{

  home.sessionVariables = {
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
  };

  home.sessionPath = [ "$CARGO_HOME/bin" ];

  home.packages =
    (with pkgs; [
      nil
      binaryen
      rustup
      brotli
      cmake
      simple-http-server
      jwt-cli
      graphviz
      hyperfine
      uv
      mprocs
      dua
    ])
    ++ [
      (callPackage (import ../extra-pkgs/wasmtime) { })
      (callPackage (import ../extra-pkgs/just) { })
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
}
