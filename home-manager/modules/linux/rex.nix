{ inputs, lib, ... }:

# Rex terminal multiplexer (https://www.superlogical.com/rex).
# Runs a personal Rex server as a systemd user service (`systemctl --user status rex`).
# To keep it running while logged out: `loginctl enable-linger`.
# Upgrade: `nix flake update rex`.
{
  imports = [ inputs.rex.homeManagerModules.default ];

  programs.rex.enable = true;   # rex CLI + xterm-rex terminfo + ssh TERM guard
  services.rex.enable = true;   # personal server (user service)

  # Rex runs its own Tailscale node inside the server (separate from tailscaled),
  # reachable at https://<hostname>.tail11d1a3.ts.net. Only the Tailscale account
  # that enrolled it may connect. First start prints a sign-in link in
  # `rex server status`. Per-host names are set in flake.nix (cf. the Mac's `brick-rex`).
  services.rex.tailscale = {
    enable = true;
    hostname = lib.mkDefault "linux-rex";
  };

  # home-manager only writes ~/.ssh/config when programs.ssh is on; Rex adds its
  # ssh guard there so remote hosts get xterm-256color instead of xterm-rex.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
}
