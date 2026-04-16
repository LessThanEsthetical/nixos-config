{ inputs, config, pkgs, ... }:

{
	home = {
		username = "furina";
		homeDirectory = "/home/furina";
		shell.enableZshIntegration = true;
		preferXdgDirectories = true;
	};
	services = { 
		gammastep = {
			enable = true;
			provider = "manual";
			latitude = 52.2;
			longitude = 21.0;
		};
	};

	xdg = {
		autostart.enable = true;
		userDirs.createDirectories = true;
	};

	programs = {
		git = {
			enable = true;
			settings.user = {
				name = "furina";
				email = "furina@example.com";
				# Change after setting on real VM
			};
		};

		kitty = {
			enable = true;
		};
	
		zsh = {
			enable = true;
			autosuggestion.enable = true;
			enableCompletion = true;
			syntaxHighlighting.enable = true;

			history = {
				expireDuplicatesFirst = true;
				ignoreSpace = true;
			};

			shellAliases = {
				check = "fastfetch";
			};
		};

		# I will include here a terminal multiplexer
		# Also known as tmux
		# Cool type shi ngl 8)

		tmux = {
			enable = true;

			aggressiveResize = true;
			baseIndex = 1;
			clock24 = true;
			mouse = true;
			historyLimit = 10000;
			secureSocket = true;
			terminal = "xterm-256color";
			keyMode = "vi";
			escapeTime = 0;
		};

		firefox = {
			enable = true;
			#arkenfox= {
				#enable = true;
				#version = "140.0";
			#};

			profiles.furina = {
				name = "furina";
				search.default = "ddg";
			};
		};
		neovim = {
			enable = true;
			initLua = ''
				vim.o.relativenumber = true
				vim.cmd("colorscheme industry")
			'';

			defaultEditor = true;
		};
		yt-dlp = {
			enable = true;
			
			settings = {
				progress = true;
				console-title = true;
			};
		};
		#hyprland = {
			#enable = true;
			#package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			#portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
		#};

	};

	#wayland.windowManager.hyprland = {
		#enable = true;
		#package = pkgs.hyprland;
		#xwayland.enable = true;
	#};
	home.stateVersion = "26.05";
}
