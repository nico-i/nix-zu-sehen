/* NixOS font configuration */
{ 
	pkgs,
	...
}: {
	config = {
		fonts = {
			packages = with pkgs; [
				(nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka" "FiraCode"];})
				cm_unicode
				corefonts
			];

			enableDefaultPackages = true;
			
			fontconfig = {
				defaultFonts = {
					monospace = ["JetBrainsMono Nerd Font Mono"];
					sansSerif = ["JetBrainsMono Nerd Font"];
					serif = ["JetBrainsMono Nerd Font"];
				};
			};
		};
	}
}
