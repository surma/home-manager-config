{ writeShellScriptBin }:
writeShellScriptBin "codesign" ''
  set -e

  exec /usr/bin/codesign $@
''
