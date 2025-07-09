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
      pip
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
  ${python}/bin/python -m venv venv
  source venv/bin/activate
  pip install ipykernel
  mkdir -p venv/conf/kernels/python
  cat << EOF > venv/conf/kernels/python
  {
   "argv": [
    "python",
    "-m",
    "ipykernel_launcher",
    "-f",
    "{connection_file}"
   ],
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "metadata": {
    "debugger": true
    }
  }
  EOF
  export JUPYTER_PATH="$PWD/venv/conf:${kernels}:$JUPYTER_PATH"
  echo =====
  echo $PATH
  echo =====
  export PATH
  ${python}/bin/jupyter lab --no-browser
''
