# WIP NixOS configuration

## How to try

### Installation
First, make sure to install `nix`  
If you're on Ubuntu, or Debian, or their derivatives (e.g. Linux Mint, Zorin OS):

    sudo apt install nix

If you're on Arch Linux or its derivatives (e.g. EndeavourOS, CachyOS):

    sudo pacman -S nix

If you're on Fedora Linux or its derivatives (e.g. Asahi Linux, Bazzite):

    sudo dnf install nix

For the rest, refer to your distro's package manager instructions.  
When installed, enable daemon and add nixpkgs-unstable channel:

    sudo systemctl enable --now nix-daemon.service && \
    nix-channel --add https://channels.nixos.org/nixpkgs-unstable && \
    nix-channel --update

Finally, enable Flakes and Nix command support:

    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

### Variations

To try vm flake on non-NixOS distro:

    nix run "github:LessThanEsthetical/nixos-config#nixosConfigurations.vm.config.system.build.vm"

Same on NixOS:

    nixos-rebuild build-vm --flake "github:LessThanEsthetical/nixos-config#vm"

Or you can use [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) for remote installation (you must have access to root via SSH):

    nix run "github:nix-community/nixos-anywhere" -- --flake "github:LessThanEsthetical/nixos-configuration#vm" --target-host root@<Put IP here>

To try out my Home-manager configuration:

    nix run "home-manager/master" -- switch --flake "github:LessThanEsthetical/nixos-config#home"

## Why

- Fully reproducible configuration.
- No clutter outside XDG user directories.
- Immutable by default.
- Atomic upgrades. If update is semi-broken, it gets discarded.
- Entire configuration is declared by one language in Git repository. Easy to pull, install and configure with one-two commands.
- Rollback feature makes it easy restore into previous state and test new things without fear.
- Nixpkgs unstable repository is [bigger than AUR](https://repology.org/repositories/graphs).
- No dependency hell.
- Same exact configuration across different machines.
- Custom shells for development.
- Home-manager standalone flake works in WSL and non-NixOS Linux distributions.

Pretty much enough to consider me switching from Arch Linux and learn Nix language.

## Structure

Output of `tree --gitignore --dirsfirst --noreport -- "./modules"`

    ./modules
    ├── common                        # Individual modules
    │   ├── hm                        # Home-manager modules
    │   │   ├── _firefox.nix
    │   │   ├── home.nix
    │   │   ├── _hyprland.nix
    │   │   ├── list.nix
    │   │   ├── media.nix
    │   │   ├── niriwm.nix
    │   │   ├── shell.nix
    │   │   └── waybar.nix
    │   └── nixos                     # System-wide modules
    │       ├── default.nix
    │       ├── firewall.nix
    │       ├── pihole.nix
    │       ├── tailscale.nix
    │       └── unbound.nix
    ├── hosts                         # Dedicated modules for specific hosts
    │   ├── home                      # Home-manager standalone flake
    │   │   └── home.nix
    │   ├── laptop                    # Laptop-specific flake, intended for testing
    │   │   ├── configuration.nix
    │   │   ├── disko.nix
    │   │   ├── facter.json
    │   │   └── laptop.nix
    │   └── vm                        # For VM in QEMU/KVM, default flake
    │       ├── configuration.nix
    │       ├── disko.nix
    │       ├── facter.json
    │       └── vm.nix
    ├── users                         # Dedicated modules for users
    │   ├── defaultUser.nix
    │   └── guestUser.nix
    └── output.nix                    # See: https://github.com/denful/den/discussions/317

## Todo

- [ ] Finish Niri setup
  - Particulary touch onto bar (waybar), notifications (mako) and terminal emulator (Alacritty?)
  - Bring wallpapers
- [x] Rewrite and reorganize flakes to use [dendritic pattern](https://discourse.nixos.org/t/the-dendritic-pattern/61271)
  - [x] Implement flake-parts
  - It may be clunky, but at least it works
- [ ] Finish Firefox setup
  - [ ] Fetch specific bookmarks
  - [ ] Apply [arkenfox's user.js](https://github.com/HeitorAugustoLN/arkenfox-nix) + custom user\_overrides.js
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
  - ~Use swap as file instead of partition?~ Keep swap as partition due to Btrfs (with subvolumes) + LVM future plans.
  - Use [rustic](https://rustic.cli.rs/) with B2 as backup solution for my $HOME?
- [ ] Use [sops-nix](https://github.com/Mic92/sops-nix) for passwords, API keys and personal text files
  - Would be nice if [secretspec](https://github.com/cachix/secretspec) integration [was possible](https://github.com/cachix/secretspec/issues/65)
- [ ] Use [NVF](https://github.com/NotAShelf/nvf) for ultimate Neovim configuration
  - Something similar to Emacs?
- [ ] \(Optionally) Add KDE Plasma entry
  - [Aeroshell](https://github.com/aeroshell-desktop/aerothemeplasma) plasma?
- [ ] \(Optionally) Check for network settings
- [ ] \(Optionally) Customize GRUB or replace it with something else ([Limine](https://github.com/Limine-Bootloader/Limine)?)
- [ ] \(Optionally) Make Hyprland setup
- Steam?
