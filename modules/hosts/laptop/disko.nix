{inputs, ...}: {
  flake.diskoConfigurations.diskolaptop = {
    imports = [inputs.disko.nixosModules.disko];
    disko.devices = {
      disk = {
        main = {
          device = "/dev/disk/by-id/ata-SAMSUNG_MZNTD128HAGM-00000_S15YNYAD643939";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                name = "EF00";
                size = "1G";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              swap = {
                size = "4G";
                content = {
                  type = "swap";
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
