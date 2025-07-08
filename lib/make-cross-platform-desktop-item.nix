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
      ${lib.strings.replicate 28 " "}
		'';
  }
else
  makeDesktopItem { inherit name desktopName exec; }
