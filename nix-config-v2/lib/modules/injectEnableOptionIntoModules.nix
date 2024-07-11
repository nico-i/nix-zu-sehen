{ lib }:
    { modulesDirPath, customConfig, customConfigName}:
        let
            getFileName = import ../fs/getFileName.nix;
            listFilesInDir = import ../fs/listFilesInDir.nix;
            injectEnableOptionIntoModule = import ./injectEnableOptionIntoModule.nix;
            moduleCategoryName = getFileName modulesDirPath;
            modules = listFilesInDir modulesDirPath;
        in
            map (modulePath: 
                        (injectEnableOptionIntoModule {
                            inherit modulePath lib customConfig customConfigName moduleCategoryName;
                        })
                ) modules
