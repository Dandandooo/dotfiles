{ pkgs, ... }:

# Shared login flow: greetd autologin into Hyprland, which then locks itself with hyprlock.
{
  programs.hyprland.enable = true;

  # Creates /etc/pam.d/hyprlock so it can check passwords. Look & feel lives in home-manager.
  programs.hyprlock.enable = true;

  # Secret Service (org.freedesktop.secrets) for apps that store credentials in the keyring (Zed, etc.).
  # Unlocks with the login password via greetd's PAM; on the autologin session it prompts on first use instead.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Autologin straight into Hyprland once per boot (Hyprland then locks itself with hyprlock).
  # After logout/crash, fall back to the tuigreet login. Only touches greetd's VT; sshd is untouched.
  # zsh -l so home-manager's session vars / PATH get loaded like a normal tty login.
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.zsh}/bin/zsh -lc 'HYPRLOCK_ON_START=1 start-hyprland'";
        user = "dani";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --cmd '${pkgs.zsh}/bin/zsh -lc start-hyprland'";
        user = "greeter";
      };
    };
  };
}
