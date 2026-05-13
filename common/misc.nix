{ pkgs, ... }:
{
	home.packages = with pkgs; [
		# Tape archiving
		zip
		xz
		gnutar

		# Working with files
		yazi
		fzf
		eza
		tree
		fd

		# Working with text
		ripgrep
		jq
    csvkit
		less
		gnused
		gawk
		wl-clipboard-rs

		# Web utilites
		curl
		wget
		aria2
		rsync
		
		# Network utilites
		iproute2
		dnsutils
		socat
		nmap

		# System utilites
		btop
		file
		gnupg
		fastfetch
		lsof
		pciutils
		usbutils
		coreutils
    comma

    # Fonts
    nerd-fonts.fira-code
	];
}
