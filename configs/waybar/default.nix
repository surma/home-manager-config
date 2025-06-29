{
  battery = {
    format = "{capacity}% {icon}";
    format-alt = "{time} {icon}";
    format-charging = "{capacity}% ";
    format-full = "{capacity}% {icon}";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
    ];
    format-plugged = "{capacity}% ";
    states = {
      critical = 15;
      warning = 30;
    };
  };
  clock = {
    format = "{:%a, %F %H:%m}";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  };
  cpu = {
    format = "{usage}% ";
    tooltip = false;
  };
  "custom/power" = {
    format = "⏻ ";
    menu = "on-click";
    menu-actions = {
      hibernate = "systemctl hibernate";
      reboot = "reboot";
      shutdown = "shutdown";
      suspend = "systemctl suspend";
    };
    menu-file = "$HOME/.config/waybar/power_menu.xml";
    tooltip = false;
  };
  "hyprland/workspaces" = {
    format = "{icon} {windows}";
    on-click = "activate";
    on-scroll-down = "hyprctl dispatch workspace e-1";
    on-scroll-up = "hyprctl dispatch workspace e+1";
  };
  idle_inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = "";
      deactivated = "";
    };
  };
  memory = {
    format = "{}% ";
  };
  modules-center = [ "clock" ];
  modules-left = [ "hyprland/workspaces" ];
  modules-right = [
    "idle_inhibitor"
    "pulseaudio"
    "power-profiles-daemon"
    "cpu"
    "memory"
    "temperature"
    "battery"
    "network"
    "tray"
    "custom/power"
  ];
  network = {
    format-alt = "{ifname}: {ipaddr}/{cidr}";
    format-disconnected = "Disconnected ⚠";
    format-ethernet = "{ipaddr}/{cidr} ";
    format-linked = "{ifname} (No IP) ";
    format-wifi = "{essid} ({signalStrength}%) ";
    tooltip-format = "{ifname} via {gwaddr} ";
  };
  power-profiles-daemon = {
    format = "{icon}";
    format-icons = {
      balanced = "";
      default = "";
      performance = "";
      power-saver = "";
    };
    tooltip = true;
    tooltip-format = "Power profile: {profile}\nDriver: {driver}";
  };
  pulseaudio = {
    format = "{volume}% {icon} {format_source}";
    format-bluetooth = "{volume}% {icon} {format_source}";
    format-bluetooth-muted = " {icon} {format_source}";
    format-icons = {
      car = "";
      default = [
        ""
        ""
        ""
      ];
      hands-free = "";
      headphone = "";
      headset = "";
      phone = "";
      portable = "";
    };
    format-muted = " {format_source}";
    format-source = "{volume}% ";
    format-source-muted = "";
    on-click = "pavucontrol";
  };
  spacing = 4;
  temperature = {
    critical-threshold = 80;
    format = "{temperatureC}°C {icon}";
    format-icons = [
      ""
      ""
      ""
    ];
  };
  tray = {
    spacing = 10;
  };
}
