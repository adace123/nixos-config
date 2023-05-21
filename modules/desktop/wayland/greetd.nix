{config, ...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = config.user.name;
      };
      default_session = initial_session;
    };
  };
}
