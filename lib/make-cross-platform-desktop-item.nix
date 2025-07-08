{
  bash,
  stdenv,
  makeDesktopItem,
  writeTextFile,
  lib,
}:
{
  name,
  desktopName,
  identifier ? "com.example.${name}",
  exec,
}:
let
in
if stdenv.isDarwin then
  writeTextFile {
    inherit name;
    destination = "/Applications/${name}.app/${name}";
    executable = true;
    text = ''
      #!${bash}/bin/bash
      exec ${exec}
      # Weirdly, the file needs to be longer than 28 bytes for MacOS to
      # respect it. This comment alone makes it longer, but you know...
      # ${lib.strings.replicate 28 " "}
    '';
  }
else
  makeDesktopItem { inherit name desktopName exec; }
