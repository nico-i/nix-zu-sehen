{ lib, helperLib }:
    { modulesDirPath, customConfig, customConfigName}:
        let
            moduleCategoryName = if !(builtins.isPath modulesDirPath)
                then throw "injectEnableOptionIntoModules: `modulesDirPath` must be a path"
                else helperLib.fs.getFileName modulesDirPath;
            modules = helperLib.fs.listFilesInDir modulesDirPath;
        in
            map (modulePath: 
                        (helperLib.modules.injectEnableOptionIntoModule {
                            inherit modulePath lib customConfig customConfigName moduleCategoryName;
                        })
                ) modules
