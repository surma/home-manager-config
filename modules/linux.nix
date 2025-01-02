{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = lib.mkDefault "surma";
  home.homeDirectory = lib.mkDefault "/home/surma";

  xdg.configFile = {
    "containers/policy.json".text = builtins.toJSON {
      default = [ { type = "insecureAcceptAnything"; } ];
    };
    "containers/registries.conf".text = ''
      unqualified-search-registries = ['docker.io']

      [[registry]]
      prefix = "docker.io"
      location = "docker.io"
    '';
  };
}
