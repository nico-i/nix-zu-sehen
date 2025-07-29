# Get the name of the target file at the target path
{ path }:
if builtins.pathExists path && builtins.isPath path then
  (builtins.head (builtins.split "\\." (baseNameOf path)))
else
  throw
  "getFileName: `path` must be a path and lead to an existing file, got: '${
    toString path
  }'"
