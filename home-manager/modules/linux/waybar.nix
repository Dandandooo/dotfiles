{ config, lib, ... }: let

in {
  programs.waybar = {
    enable = true;      
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          "custom/sep"
          "cpu"
          "custom/gpu"
          "memory"
          "custom/sep"
          "custom/sleep"
          "clock" 
        ];

        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%H:%M}";
          tooltip = false;
          tooltip-format = "{:%a %h %e}";
        };

        cpu = {
          format = " {usage}%";
          interval = 2;
        };

        "custom/gpu" = {
          exec = "cat /sys/bus/pci/devices/0000:09:00.0/gpu_busy_percent";
          format = "󰢮 {}%";
          return-type = "";
          interval = 2;
        };

        memory = {
          format = " {}%";
          tooltip = false;
        };

        "custom/sep" = {
          format = "|";
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-icons = {
            "default" = ["" "" "" ];
          };
          format-muted = " {volume}%";
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
          scroll-step = 5;
        };

        "custom/sleep" = {
          on-click = "systemctl suspend";
          format = "󰤄";
          tooltip = false;
        };

        "hyprland/window" = {
          tooltip = false;
          format = "{class}";
        };

        "hyprland/workspaces" = {
          "persistent-workspaces" = {
            "*" = 10;
            "DP-3" = [1 3 5 7 9];
            "HDMI-A-1" = [2 4 6 8 10];
          };
          "workspace-taskbar" = {
            enable = true;
          };
        };
      };
    };
    style = ''
      * {
        color: @base0A;
        font-family: MonaspiceRn Nerd Font;
        font-size: 12pt;
        font-weight: bold;
        background-image: url("https://grainy-gradients.vercel.app/noise.svg");
        background-repeat: repeat;
        background-blend-mode: multiply;
      }

      .modules-right * {
        margin: 0 0.5rem;
      }

      #custom-sep {
        color: @base02;
        font-size: 16pt;
        font-weight: lighter;
        margin: -3pt 0;
      }

      #pulseaudio.muted {
        color: @base08;
      }

      #custom-sleep {
        font-size: 16pt;
      }

      #window {
        font-family: Lemon;
        font-size: 12pt;
      }

      #workspaces button.empty {
        color: @base03;
      }

      #workspaces {
        padding: 0.25em;
        margin: 0;
      }

      #workspaces button {
        /* font-size: 10pt; */
        border: 2px transparent solid;
      }

      #workspaces button.active {
        color: @base0C;
        /* font-size: 12pt; */
        border: 2px @base0D solid;
      }


      window {
        border-bottom: 2px @base0D solid;
      }

      tooltip {
        border: 2px @base0D dashed;
        font-family: scientifica;
      }

      #clock {
        font-size: 14pt; 
        font-family: scientifica;
        font-weight: normal;
        border: 2px @base0D solid;
        border-right: 0;
        border-radius: 0.5rem 0 0 0.5rem;
        padding: 0 0.25rem 0 0.5rem;
        margin: 0.5rem 0 0.5rem 0.5rem;
      }
    '';
    systemd = {
      enable = true;
      enableInspect = true;
    };
  };
}
