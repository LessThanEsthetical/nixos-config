{ inputs, ... }:

{
  flake.diskoConfigurations.diskopc = { 
    disko.devices = {
      disk = {
        main = {
	  imageSize = "50G";
          device = "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                name = "EF00";
                size = "+1G";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              swap = {
                size = "20G";
                content = {
                  type = "swap";
                  randomEncryption = true;
                  resumeDevice = true;
                  discardPolicy = "both";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
