{ ... }:

{
  services.polybar = {
    enable = true;

    script = "polybar bar &";
    settings = {
      "module/date" = {
        type = "internal/date";
	date = "%Y-%m-%d";
      };
    }; # Maybe add settings later idk
  };
}
