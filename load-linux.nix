{
  system-manager,
  nix-system-graphics,
  ...
}@inputs:
{ machine, system }:
system-manager.lib.makeSystemConfig {
  modules = [
    nix-system-graphics.systemModules.default
    ./system-manager/home-manager.nix
    machine
    (
      { pkgs, ... }:
      {
        nixpkgs.hostPlatform = system;
        environment.systemPackages = [
          system-manager.packages.${system}.default
        ];
        environment.etc."zprofile".text = ''
          emulate sh -c "source /etc/profile"
        '';
      }
    )
  ];
  extraSpecialArgs = {
    inherit inputs system;
    systemManager = "system-manager";
  };
}
