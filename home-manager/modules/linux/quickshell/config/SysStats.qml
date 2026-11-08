pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// CPU / GPU / memory usage and power draw, read straight from /proc and /sys
// (no processes forked per tick).
Singleton {
    id: root

    property int cpu: 0
    property int gpu: 0
    property int memory: 0
    property real cpuWatts: 0
    property real gpuWatts: 0

    readonly property string gpuDevice: "/sys/bus/pci/devices/0000:09:00.0"
    // RAPL package energy counter; readable thanks to the udev rule in
    // nixos/configuration.nix.
    readonly property string rapl: "/sys/class/powercap/intel-rapl:0"

    property var prevCpu: null
    property real prevEnergy: -1
    property real prevEnergyTime: 0

    // ---- 2s: cpu, gpu busy, memory ----
    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            stat.reload();
            gpuBusy.reload();
            meminfo.reload();
        }
    }

    FileView {
        id: stat
        path: "/proc/stat"
        onLoaded: {
            const f = text().split("\n")[0].trim().split(/\s+/).slice(1).map(Number);
            const idle = f[3] + f[4];
            const total = f.reduce((a, b) => a + b, 0);
            if (root.prevCpu) {
                const dt = total - root.prevCpu.total;
                if (dt > 0)
                    root.cpu = Math.round(100 * (1 - (idle - root.prevCpu.idle) / dt));
            }
            root.prevCpu = { idle, total };
        }
    }

    FileView {
        id: gpuBusy
        path: root.gpuDevice + "/gpu_busy_percent"
        onLoaded: root.gpu = parseInt(text()) || 0
    }

    FileView {
        id: meminfo
        path: "/proc/meminfo"
        onLoaded: {
            const kb = key => parseInt(text().match(new RegExp(key + ":\\s+(\\d+)"))[1]);
            root.memory = Math.round(100 * (1 - kb("MemAvailable") / kb("MemTotal")));
        }
    }

    // ---- 1s: power ----
    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            energy.reload();
            if (gpuPower.path !== "")
                gpuPower.reload();
        }
    }

    FileView {
        id: energyMax
        path: root.rapl + "/max_energy_range_uj"
        blockLoading: true
    }

    FileView {
        id: energy
        path: root.rapl + "/energy_uj"
        onLoaded: {
            const e = parseFloat(text());
            const now = Date.now();
            if (root.prevEnergy >= 0) {
                let de = e - root.prevEnergy;
                if (de < 0)
                    de += parseFloat(energyMax.text());
                root.cpuWatts = de / ((now - root.prevEnergyTime) * 1000);
            }
            root.prevEnergy = e;
            root.prevEnergyTime = now;
        }
    }

    // hwmonN changes between boots; resolve the glob once at startup.
    Process {
        running: true
        command: ["sh", "-c", `echo ${root.gpuDevice}/hwmon/hwmon*/power1_average`]
        stdout: StdioCollector {
            onStreamFinished: gpuPower.path = this.text.trim()
        }
    }

    FileView {
        id: gpuPower
        path: ""
        onLoaded: root.gpuWatts = parseInt(text()) / 1e6
    }
}
