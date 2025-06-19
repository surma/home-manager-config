{
  lib,
  deno,
  writeTextFile,
  python3,
  symlinkJoin,
  writeShellScriptBin,
}:
let
  python = python3.withPackages (
    ps: with ps; [
      jupyter
      ipython
    ]
  );

  denoKernelSpec = {
    argv = [
      "${deno}/bin/deno"
      "jupyter"
      "--kernel"
      "--conn"
      "{connection_file}"
    ];
    display_name = "Deno";
    language = "typescript";
  };

  denoKernelSpecFile = writeTextFile {
    name = "deno-kernel";
    destination = "/kernels/deno/kernel.json";
    text = builtins.toJSON denoKernelSpec;
  };

  kernels = symlinkJoin {
    name = "kernels";
    paths = [ denoKernelSpecFile ];
  };
in
writeShellScriptBin "jupyter-start" ''
  export JUPYTER_PATH="${kernels}:$JUPYTER_PATH"
  ${python}/bin/jupyter lab --no-browser
''
