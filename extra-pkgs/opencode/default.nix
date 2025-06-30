{
  buildNpmPackage,
  stdenv,
  pkgs,
  nodejs ? pkgs.nodejs_24,
  system,
  writeShellScriptBin,
  ...
}:
let
  pname = "opencode-ai";
  version = "0.1.166";

  opencodeMeta = {
    "x86_64-linux" = {
      platform = "linux-x64";
      hash = "sha256:0im089zmb7ykx0yqv98djqw9kmn356am3qk67b32h5s7a99l3i8f";
    };
    "aarch64-darwin" = {
      platform = "darwin-arm64";
      hash = "";
    };
  };

  meta = opencodeMeta.${system};

  package = fetchTarball {
    url = "https://registry.npmjs.org/opencode-${meta.platform}/-/opencode-${meta.platform}-${version}.tgz";
    sha256 = meta.hash;
  };
in

package
