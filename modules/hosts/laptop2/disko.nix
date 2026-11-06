# This combines LVM with Btrfs subvols + dedicated UEFI boot partition
# LVM for combining two disks into one
# Btrfs for the rest (except swap)
{inputs, ...}: {
  flake.diskoConfigurations.diskolaptop2 = {
    imports = [inputs.disko.nixosModules.disko];
    disko.devices = {
      disk = {
        one = {
          device = "/dev/disk/by-id/ata-Netac_SSD_512GB_AA20250915512G160574";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                label = "BOOT";
                name = "ESP";
                type = "EF00";
                size = "1G";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
        two = {
          device = "/dev/disk/by-id/ata-SanDisk_SSD_i100_24GB_122500134263";
          type = "disk";
          content = {
            type = "gpt";
            partitions.primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
      lvm_vg = {
        pool = {
          type = "lvm_vg";
          lvs = {
            swap = {
              name = "swap";
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
                discardPolicy = "both";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "nixos" "-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
    };
    boot.zswap.enable = true;
  };
}
