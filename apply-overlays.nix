{ lib, ... }@args:
overlays:
let
  import' = l: if builtins.isPath l then (import l args) else l;
  overlays' = lib.lists.map (o: import' o) overlays;
  result = lib.lists.foldl (acc: o: acc // (o result acc)) { } overlays';
in
result