/* Create a list of directories in a given directory */
{ inputs, lib, withPath ? true }: { dir }: 
let
        containedDirs = 
                if builtins.pathExists dir && lib.filesystem.pathIsDirectory dir
                then lib.attrNames (inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory") (builtins.readDir dir))
                else throw "listDirsInDir: `dir` must be an existing directory";
in
        if withPath
        then builtins.map (dirName: "${dir}/${dirName}") containedDirs
        else containedDirs