{ ... }:

{
  services.polybar = {
    enable = true;

    script = "polybar bar &";
    settings = {
      "module/date" = {
        type = "internal/date";
        interval = 1.0;
        date = "%Y-%m-%d";
        time = "%H:%M";
      };
      "bar/mybar" = {
        width = "100%";
        fixed-center = false;
        offset-y = "5%";
        radius = 6.0;
        modules-right = "date";
      };
    }; # Maybe add settings later idk
  };
}
