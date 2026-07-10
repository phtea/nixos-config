{
	description = "Phtea's NixOS configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
	};

	outputs = { self, nixpkgs }: {
		nixosConfigurations.laptop =
			nixpkgs.lib.nixosSystem {
				system = "x86-64-linux";

				modules = [
					./hosts/laptop/default.nix
				];
			};
	};
}
