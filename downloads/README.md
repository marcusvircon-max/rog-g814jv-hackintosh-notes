# 驱动下载

- [AirportItlwm 2.4.0 — Tahoe x86_64](AirportItlwm-Tahoe-x86_64.zip)。本机 ROG G814JV 的 Intel AX211（8086:7A70）已实测原生 Wi-Fi 开关可用。二进制 UUID 为 `CF0E0D77-F07F-31E6-B0B9-B5ABB352C0A5`。
- [对应源码与构建依赖](AirportItlwm-Tahoe-x86_64-source.zip)，基于 AirportItlwm-AX211 提交 `030ef90b17d3d99a12f4415fec66f063dff111a5`。
- [SHA-256 校验值](SHA256SUMS)。

安装前备份 EFI。将 AirportItlwm.kext 加入 OpenCore 的 Kernel → Add，限制为 Darwin 25.x，禁用旧 itlwm 注入。重启后检查原生 Wi-Fi 开关和连接。回退时恢复备份的 EFI 配置。

## RTX 4060 Laptop

[下载本机实测的 NullMoth 3.0 内核组件 ZIP](RTX4060-NullMoth-3.0-Tahoe-x86_64.zip)。包含 NVRM、NVAccel、NVRMAGDC、诊断版 NVRMFB 和 NMXAudio，共五个 kext 及 UUID 清单。按 NullMoth 非商业许可分发。

这是内核组件归档。先用 [NullMoth 3.0 官方安装包](https://github.com/nullmoth/nvidia-macos-driver/releases/tag/v3.0)取得匹配的用户态组件和 NVIDIA 固件。备份原有组件与 AuxKC 后，再按本机验证记录部署诊断版。G814JV 实测用第二个 USB-C 输出和原生 HDMI。

## Cirrus 内置扬声器

公开提供 [G814JV 补丁](../patches/cirrus-g814.patch) 和 [OEM 固件导入脚本](../scripts/import-g814-cirrus-firmware.sh)。预编译的本机版本嵌入了 Windows OEM 固件和扬声器系数，尚未确认这些 OEM 文件的再分发授权。请从自己机器的 Windows DriverStore 导入，再按[构建说明](../docs/drivers.md)编译。
