# List the files (paths) in a given directory
{ lib }:
{ dir }:
if builtins.pathExists dir && lib.filesystem.pathIsDirectory dir then
  map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir))
else
  throw
  "listFilesInDir: `dir` must be an existing directory, got: '${toString dir}'"
