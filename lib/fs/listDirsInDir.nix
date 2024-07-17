/* Create a list of directories in a given directory */
{ inputs }: { dir }: 
        if builtins.pathExists dir && lib.filesystem.pathIsDirectory dir
        then inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory") (builtins.readDir dir)
        else throw "listDirsInDir: `dir` must be an existing directory"