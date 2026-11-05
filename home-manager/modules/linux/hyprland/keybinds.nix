{ pkgs, ... }:

{
    wayland.windowManager.hyprland.extraConfig = ''
        local mainMod = "SUPER"

        local function bind(keys, dispatcher, opts)
            hl.bind(mainMod .. " + " .. keys, dispatcher, opts)
        end
        local function exec(cmd) return hl.dsp.exec_cmd(cmd) end

        bind("END", hl.dsp.exit())

        bind("F", hl.dsp.window.float({ action = "toggle" }))
        bind("SHIFT + F", hl.dsp.window.fullscreen())
        bind("P", hl.dsp.window.pseudo())
        bind("J", hl.dsp.layout("togglesplit"))
        bind("K", hl.dsp.window.close())

        bind("Q", exec("${pkgs.kitty}/bin/kitty"))
        bind("ALT + Q", exec("${pkgs.warp-terminal}/bin/warp-terminal"))

        bind("B", exec("${pkgs.firefox}/bin/firefox"))
        bind("ALT + B", exec("zen"))

        bind("M", exec("spotify"))

        bind("R", exec("${pkgs.wofi}/bin/wofi --show drun"))

        bind("G", exec("steam"))
        bind("D", exec("vesktop"))

        for _, dir in ipairs({ "left", "right", "up", "down" }) do
            bind(dir, hl.dsp.focus({ direction = dir }))
            bind("SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
        end

        for i = 1, 10 do
            local key = i % 10 -- 10 maps to key 0
            bind(key, hl.dsp.focus({ workspace = i }))
            bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
        end

        bind("S", hl.dsp.workspace.toggle_special("magic"))
        bind("SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

        bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
        bind("mouse_up", hl.dsp.focus({ workspace = "e-1" }))

        bind("mouse:272", hl.dsp.window.drag(), { mouse = true })
        bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

        -- media keys (no modifier)
        hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
        hl.bind("XF86AudioPlay", exec("playerctl play-pause"))
        hl.bind("XF86AudioNext", exec("playerctl next"))
        hl.bind("XF86AudioPrev", exec("playerctl previous"))

        -- volume (repeats while held)
        local volUp = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ +10%"
        local volDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ -10%"
        hl.bind("XF86AudioRaiseVolume", exec(volUp), { repeating = true })
        hl.bind("XF86AudioLowerVolume", exec(volDown), { repeating = true })
        bind("Page_Up", exec(volUp), { repeating = true })
        bind("Page_Down", exec(volDown), { repeating = true })
    '';
}
