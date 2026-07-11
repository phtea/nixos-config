{ ... }:

{
	programs.lazygit = {
		enable = true;

		settings = {
			gui = {
				skipDiscardChangeWarning = false;
				language = "en";

				theme = {
					cherryPickedCommitBgColor = [ "#205247" ];
					cherryPickedCommitFgColor = [ "#4EC9B0" ];
					defaultFgColor = [ "#d4d4d4" ];

					inactiveBorderColor = [ "#808080" ];
					optionsTextColor = [ "#dcdcaa" ];

					searchingActiveBorderColor = [
						"#6A9955"
						"bold"
					];

					selectedLineBgColor = [ "#264f78" ];
					unstagedChangesColor = [ "#f44747" ];

					activeBorderColor = [
						"#6A9955"
						"bold"
					];
				};
			};

			os = {
				editPreset = "nvim-remote";

				editAtLine =
					''[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send "{{line}}gg")'';

				openDirInEditor =
					''[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{dir}})'';

				edit =
					''[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})'';

				openInTerminal = ''[ -z "$NVIM" ]'';
			};
		};
	};
}
