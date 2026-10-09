{ config, lib, pkgs, ... }: let
  # Long-running loop using only bash builtins, so nothing is forked per tick.
  # CPU: RAPL package energy counter (made readable by a udev rule in nixos/configuration.nix).
  # GPU: amdgpu hwmon average power.
  powerScript = pkgs.writeShellScript "waybar-power" ''
    rapl=/sys/class/powercap/intel-rapl:0
    gpu=
    for f in /sys/bus/pci/devices/0000:09:00.0/hwmon/hwmon*/power1_average; do
      [[ -r $f ]] && gpu=$f
    done
    read -r max < "$rapl/max_energy_range_uj"
    exec {sleepfd}<> <(:)

    prev_e=
    while :; do
      now=''${EPOCHREALTIME/./}
      e=
      [[ -r $rapl/energy_uj ]] && read -r e < "$rapl/energy_uj"
      cpu=0
      if [[ -n $e && -n $prev_e ]]; then
        de=$(( e - prev_e ))
        (( de < 0 )) && de=$(( de + max ))
        cpu=$(( de * 10 / (now - prev_t) ))  # deciwatts
      fi
      prev_e=$e prev_t=$now

      g=0
      [[ -n $gpu ]] && read -r g < "$gpu" && g=$(( g / 100000 ))  # µW -> dW

      t=$(( cpu + g ))
      printf '{"text":"%d.%dW","tooltip":"CPU %d.%dW\\nGPU %d.%dW"}\n' \
        $((t/10)) $((t%10)) $((cpu/10)) $((cpu%10)) $((g/10)) $((g%10))
      read -t 1 -u $sleepfd
    done
  '';
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
          "custom/power"
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

        "custom/power" = {
          exec = "${powerScript}";
          return-type = "json";
          format = "󱐋 {}";
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
