{
  pkgs ? import <nixpkgs> { },
}:
fetchTarball {
  url = "https://github.com/nix-community/fenix/archive/1270fb024c6987dd825a20cd27319384a8d8569e.tar.gz";
  sha256 = "sha256-GKlvM9M0mkKJrL6N1eMG4DrROO25Ds1apFw3/b8594w=";
}
# pkgs.fetchFromGitHub { 
# 	owner = "nix-community";
# 	repo = "fenix";
# 	rev = "1270fb024c6987dd825a20cd27319384a8d8569e";
# 	hash = "sha256-GKlvM9M0mkKJrL6N1eMG4DrROO25Ds1apFw3/b8594w=";
# }
