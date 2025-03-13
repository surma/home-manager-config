{ pkgs, system, ... }@args:
{
  homebrew = {
    casks = [
      "nvidia-geforce-now"
      "magicavoxel"
    ];
  };
}
