# Injects the name of the directory containing the given configuration file into `networking.hostName`.
#
# Usage:
#
# ```nix
# # Results in { config, ... }: { config.networking.hostName = "my-machine"; }
# import ./injectConfigDirNameAsHostName.nix { cfgPath = hosts/myconfig/configuration.nix; }
# ```
{ cfgPath }:
let
  hostName =
    if !(builtins.isPath cfgPath) then
      throw "injectConfigDirNameAsHostName: `cfgPath` must be a path"
    else
      builtins.baseNameOf (builtins.dirOf cfgPath);
in
{ config, ... }:
{
  config.networking.hostName = hostName;
}
