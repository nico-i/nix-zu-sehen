{ inputs }: {
  getSysPkgs = (import ./getSysPkgs.nix) { inherit inputs; };
  injectConfigDirNameAsHostName = (import ./injectConfigDirNameAsHostName.nix);
}
