{ pkgs, ... }:

{
	home.packages = [
		(pkgs.chromium.override {
			commandLineArgs = [
				"--ozone-platform-hint=auto"
				"--enable-features=UseOzonePlatform"
				"--force-dark-mode"
			];
		})
	];
}
