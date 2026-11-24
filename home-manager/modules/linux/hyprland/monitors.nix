{ lib, ... }:

# Monitor handling, decided at runtime from what is actually plugged in (no
# per-host config). Two independent rules:
#
#   * scale      – per monitor, from that monitor's own native resolution
#                  (4k-class -> 1.5, anything smaller -> 1). Ignores how many
#                  monitors there are.
#   * workspaces – from the number of connected monitors: one monitor holds
#                  1-10; two or more puts odd on the left one and even on the
#                  right one. Ignores resolution/scale.
#
# Everything is re-evaluated on config load/reload and whenever a monitor is
# plugged in or unplugged. Quickshell's Workspaces.qml applies the same
# count-based rule to the bar from its own screen list.
{
    wayland.windowManager.hyprland.extraConfig = lib.mkBefore ''
        -- Connected monitors, left-to-right order = sorted by output name
        -- (so on the dual setup DP-3 is left, HDMI-A-1 right). `except` drops
        -- a monitor that is in the middle of being removed.
        local function connected_monitors(except)
            local mons = {}
            for _, m in ipairs(hl.get_monitors()) do
                if m.name ~= except and m.name ~= "FALLBACK" then
                    table.insert(mons, m)
                end
            end
            table.sort(mons, function(a, b) return a.name < b.name end)
            return mons
        end

        -- Largest mode the monitor supports (what "highres" picks).
        local function native_mode(mon)
            local best = { width = mon.width or 0, height = mon.height or 0 }
            for _, m in ipairs(mon.available_modes or {}) do
                if m.width * m.height > best.width * best.height then best = m end
            end
            return best
        end

        -- ── Rule 1: scale, by resolution ────────────────────────────────
        local function scale_for(mon)
            return (native_mode(mon).height >= 2160) and 1.5 or 1
        end

        local function apply_scale(mons)
            local gdk = 1
            for _, mon in ipairs(mons) do
                local s = scale_for(mon)
                hl.monitor({ output = mon.name, mode = "highres@highrr", scale = s, vrr = 2 })
                if s > gdk then gdk = s end
            end
            hl.env("GDK_SCALE", tostring(gdk)) -- process-wide, so use the largest
        end

        -- Place monitors side by side. Positions are in logical pixels, so
        -- this reads each monitor's scale, but it doesn't choose scales.
        local function apply_positions(mons)
            local x = 0
            for _, mon in ipairs(mons) do
                hl.monitor({ output = mon.name, position = x .. "x0" })
                x = x + math.floor(native_mode(mon).width / scale_for(mon))
            end
        end

        -- ── Rule 2: workspaces, by monitor count ────────────────────────
        local function workspace_target(mons, i)
            if #mons >= 2 then
                return (i % 2 == 1) and mons[1].name or mons[2].name
            end
            return mons[1].name
        end

        local function apply_workspaces(mons, move_existing)
            if #mons == 0 then return end
            for i = 1, 10 do
                hl.workspace_rule({ workspace = tostring(i), monitor = workspace_target(mons, i) })
            end
            -- Rules only apply when a workspace is created, so on hotplug
            -- also move the workspaces that already exist.
            if not move_existing then return end
            for _, ws in ipairs(hl.get_workspaces()) do
                local id = ws.id
                if id and id >= 1 and id <= 10 then
                    local target = workspace_target(mons, id)
                    if not ws.monitor or ws.monitor.name ~= target then
                        hl.dispatch(hl.dsp.workspace.move({ workspace = id, monitor = target }))
                    end
                end
            end
        end

        local function refresh_monitors(except, move_existing)
            local mons = connected_monitors(except)
            apply_scale(mons)
            apply_positions(mons)
            apply_workspaces(mons, move_existing)
        end

        refresh_monitors(nil, false)
        hl.on("monitor.added",   function(_)   refresh_monitors(nil, true) end)
        hl.on("monitor.removed", function(mon) refresh_monitors(mon.name, true) end)
    '';
}
