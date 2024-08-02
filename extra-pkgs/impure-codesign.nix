{ writeShellScriptBin, bash }:
writeShellScriptBin "codesign" ''
  #!${bash}/bin/bash

  set -e

  exec /usr/bin/codesign $@
''
