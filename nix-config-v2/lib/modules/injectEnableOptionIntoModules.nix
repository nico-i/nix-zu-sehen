{ lib, helperLib }:
    { modulesDirPath, customConfig, customConfigName}:
        let
            moduleCategoryName = if !(builtins.isPath modulesDirPath)
                then throw "injectEnableOptionIntoModules: `modulesDirPath` must be a path"
                else helperLib.fs.getFileName modulesDirPath;
            modulePaths = helperLib.fs.listFilesInDir modulesDirPath;
            modules = if builtins.isList modulePaths
                then modulePaths
                else throw "injectEnableOptionIntoModules: `modulesDirPath` must be a directory";
        in
            map (modulePath: helperLib.modules.injectEnableOptionIntoModule 
                    {
                        inherit modulePath lib customConfig customConfigName moduleCategoryName;
                    }
                ) modules
