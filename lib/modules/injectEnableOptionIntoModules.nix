{ lib, helperLib }:
    { modulesDirPath, customConfig, customConfigName}:
        let
            moduleCategoryName =
                if builtins.pathExists modulesDirPath && lib.filesystem.pathIsDirectory modulesDirPath
                then helperLib.fs.getFileName { path = modulesDirPath; }
                else throw "injectEnableOptionIntoModules: `modulesDirPath` must be a dir path, got: '${toString modulesDirPath}'";

            modules = helperLib.fs.listFilesInDir { dir = modulesDirPath; };
        in
            map (modulePath: helperLib.modules.injectEnableOptionIntoModule 
                    {
                        inherit modulePath customConfig customConfigName moduleCategoryName;
                    }
                ) modules
