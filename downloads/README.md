# 驱动下载

- [AirportItlwm 2.4.0 — Tahoe x86_64](AirportItlwm-Tahoe-x86_64.zip)。本机 ROG G814JV 的 Intel AX211（8086:7A70）已实测原生 Wi-Fi 开关可用。二进制 UUID 为 `CF0E0D77-F07F-31E6-B0B9-B5ABB352C0A5`。
- [对应源码与构建依赖](AirportItlwm-Tahoe-x86_64-source.zip)，基于 AirportItlwm-AX211 提交 `030ef90b17d3d99a12f4415fec66f063dff111a5`。
- [SHA-256 校验值](SHA256SUMS)。

安装前备份 EFI。将 AirportItlwm.kext 加入 OpenCore 的 Kernel → Add，限制为 Darwin 25.x，禁用旧 itlwm 注入。重启后检查原生 Wi-Fi 开关和连接。回退时恢复备份的 EFI 配置。

RTX 4060 和 NMXAudio 的原版驱动可从 [NullMoth 官方发布页](https://github.com/nullmoth/nvidia-macos-driver/releases)下载。本机验证过的 NVRMFB 诊断构建与上游原版有差异。Cirrus 扬声器驱动的本机二进制包含 Windows OEM 固件，当前公开提供[补丁与构建说明](../docs/drivers.md)。
