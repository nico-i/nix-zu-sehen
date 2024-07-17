/* Create a list of directories in a given directory */
{ inputs, lib }: { dir }: 
        if builtins.pathExists dir && lib.filesystem.pathIsDirectory dir
        then lib.attrNames (inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory") (builtins.readDir dir))
        else throw "listDirsInDir: `dir` must be an existing directory, got: '${toString dir}'"