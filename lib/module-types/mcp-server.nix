lib:
with lib;
types.submodule {
  options = {
    type = mkOption {
      type = types.str;
      default = "stdio";
    };
    command = mkOption {
      type =
        with types;
        oneOf [
          str
          (listOf str)
        ];
    };
    args = mkOption {
      type = with types; listOf str;
      default = [ ];
    };
    env = mkOption {
      type = with types; attrsOf str;
      default = { };
    };
  };
}
