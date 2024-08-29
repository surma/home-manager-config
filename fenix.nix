{
  pkgs ? import <nixpkgs> { },
}:
fetchTarball {
  url = "https://github.com/nix-community/fenix/archive/2d808ed09caffa0984a6d54bc1558959d48b012b.tar.gz";
  sha256 = "sha256:1cm2qa2w5rp3y90rwryqy0iqlm3j9dx8wqva0cdhjlqk2ykhc00a";
}
