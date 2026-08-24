# WIP NixOS configuration

## How to try
First, make sure to install `nix`\
```sudo apt install nix # If you use Ubuntu or Debian```\
```sudo pacman -S nix # If you use Arch Linux```\
```
sudo systemctl enable --now nix-daemon.service && \
nix-channel --add https://channels.nixos.org/nixpkgs-unstable && \
nix-channel --update
```

On non-NixOS distro (install Nix command first):\
```nix run "github:LessThanEsthetical/nixos-config#nixosConfigurations.main-pc.config.system.build.vm"```\
On NixOS:\
```nixos-rebuild build-vm --flake "github:LessThanEsthetical/nixos-config#main-pc"```\
Or you can try this for remote installation (you must have access to root):\
```nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-facter ./facter.json --flake github:LessThanEsthetical/nixos-configuration#main-pc --target-host root@<Put IP here>```

## Why
I liked the idea of a reproducible, immutable, uncluttered and stable system, of which entire configuration can be stored inside Git repository.\
Although, I still like Arch Linux that I've been using ~2.5 years as a general purpose OS.\
Problems with Arch are:
- There's a chance your next update will brick the system, albeit pretty small.
- Next time you're going to reinstall Arch Linux, it'll be hard to reproduce.
- You still need to separately update AUR packages, sometimes even rebuilding them.

## Structure
```
./modules
├── common                      # All separate modules specified here
│   ├── hm                      # Home-manager modules
│   │   ├── _firefox.nix
│   │   ├── home.nix
│   │   ├── _hyprland.nix
│   │   ├── list.nix
│   │   ├── mpv.nix
│   │   ├── niriwm.nix
│   │   ├── output.nix
│   │   ├── shell.nix
│   │   └── waybar.nix
│   └── nixos                   # System-wide modules
│       ├── configuration.nix
│       ├── firewall.nix
│       ├── pihole.nix
│       ├── tailscale.nix
│       └── unbound.nix
├── hosts                       # Host-specific modules
│   └── main-pc
│       ├── configuration.nix
│       ├── disko.nix
│       ├── facter.json
│       └── main-pc.nix
└── users                       # User-specific modules
    ├── yuuki.nix
    └── john.nix
```

## Todo
- [ ] Finish Niri setup
  - Particulary touch onto bar (waybar), notifications (mako) and terminal emulator (Alacritty?)
  - Bring wallpapers
- [x] Rewrite and reorganize flakes to use [dendritic pattern](https://discourse.nixos.org/t/the-dendritic-pattern/61271)
  - [x] Implement flake-parts
  - It may be clunky, but at least it works
- [ ] Finish Firefox setup
  - [ ] Fetch specific bookmarks
  - [ ] Apply [arkenfox's user.js](https://github.com/HeitorAugustoLN/arkenfox-nix) + custom user_overrides.js
  - [ ] Add uBlock Origin extension + custom filters and settings
- [ ] Create configurations for servers as well
  - [ ] Raspberry Pi
  - [ ] VPS 
- [ ] Somehow harden setup
  - [nix-mineral](https://github.com/cynicsketch/nix-mineral)?
- [ ] Harden bootloading chain
  - [ ] Implement TPM 2.0 module
  - [x] Use UEFI instead of BIOS
  - [Lanzaboote](https://github.com/nix-community/lanzaboote) for Secure Boot?
- [ ] Implement [disko](https://github.com/nix-community/disko)
  - [ ] Switch from ext4 to btrfs
    - Backups with snapshots?
  - [ ] Use LVM-on-LUKS
  - [ ] [Impermanence](https://github.com/nix-community/impermanence) module sounds fun
  - Use swap as file instead of partition?
  - Use [rustic](https://rustic.cli.rs/) with B2 as backup solution for my $HOME?
- [ ] Use [sops-nix](https://github.com/Mic92/sops-nix) for passwords, API keys and personal text files
- [ ] Use [NVF](https://github.com/NotAShelf/nvf) for ultimate Neovim configuration
  - Something similar to Emacs?
- [ ] \(Optionally) Add KDE Plasma entry
  - [Aeroshell](https://github.com/aeroshell-desktop/aerothemeplasma) plasma?
- [ ] \(Optionally) Check for network settings
- [ ] \(Optionally) Customize GRUB or replace it with something else ([Limine](https://github.com/Limine-Bootloader/Limine)?)
- [ ] \(Optionally) Make Hyprland setup
- Steam?
