/* Get the name of the target file at the target path */
{ path }:
    if builtins.pathExists path 
	then (builtins.head (builtins.split "\\." (baseNameOf path)))
    else throw "getFileName: `path` must lead to an existing file, got: '${toString path}'"
