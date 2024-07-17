{ lib, helperLib }:
    { modulesDirPath, customConfig, customConfigName}:
        let
            moduleCategoryName = if !(builtins.isPath modulesDirPath)
                then throw "injectEnableOptionIntoModules: `modulesDirPath` must be a path, got: '${toString modulesDirPath}'"
                else helperLib.fs.getFileName { path = modulesDirPath; };

            modulePaths = helperLib.fs.listFilesInDir { dir = modulesDirPath; };

            modules = if !(builtins.isList modulePaths)
                then throw "injectEnableOptionIntoModules: `modulesDirPath` must be a directory, got: '${toString modulesDirPath}'"
                else modulePaths;
        in
            map (modulePath: helperLib.modules.injectEnableOptionIntoModule 
                    {
                        inherit modulePath customConfig customConfigName moduleCategoryName;
                    }
                ) modules
