let
  applyOverlays =
    overlays:
    args@{
      config,
      pkgs,
      lib,
      ...
    }:
    let
      base = import ./base.nix args;
      overlays' = lib.map (o: import o args) overlays;
      result = lib.foldl (acc: o: acc // (o result acc)) (base result) overlays';
    in
    result;
in
rec {
  default = surmbook;
  surmbook = applyOverlays [ ./machines/surmbook.nix ];
  shopify = applyOverlays [ ./machines/shopify.nix ];

  # This is what makes `home-manager switch` enable the `default` config
  # when no explicit `-A <profile name>` is present.
  __functor =
    self:
    args@{
      config,
      pkgs,
      lib,
      ...
    }:
    default args;
}
