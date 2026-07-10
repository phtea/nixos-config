{
	description = "Phtea's NixOS configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }: {
		nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
			system = "x86-64-linux";

			modules = [
				./hosts/laptop/default.nix

				home-manager.nixosModules.home-manager

				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.phtea = import ./home/phtea.nix;
				}
			];
		};
	};
}
