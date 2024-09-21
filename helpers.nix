{
  applyOverlays =
    overlays:
    args@{
      config,
      pkgs,
      lib,
      ...
    }:
    let
      import' = l: args: if builtins.isPath l then import l args else l;
      overlays' = lib.lists.map (o: import' o args) overlays;
      result = lib.lists.foldl (acc: o: acc // (o result acc)) { } overlays';
    in
    result;
}
