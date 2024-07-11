/* Create a list of files (paths) in a given directory */
{ dir }: 
    if builtins.pathExists dir && builtins.isDir dir
    then map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir))
    else throw "listFilesInDir: `dir` must be an existing directory"
