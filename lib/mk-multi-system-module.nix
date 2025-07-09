let
  mkMultiSystemModule =
    name: configs:
    {
      systemManager,
      ...
    }:
    let
      activeModule =
        if configs ? "${systemManager}" then
          configs.${systemManager}
        else
          throw "Unsupported system manager ${
            systemManager |> builtins.toJSON
          } for ${name |> builtins.toJSON}";
    in
    {
      imports = [ activeModule ];
    };
in
mkMultiSystemModule
