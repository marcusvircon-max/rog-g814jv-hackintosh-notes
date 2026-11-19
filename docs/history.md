# 修复历程

1. 从 macOS 和 Windows 分别采集硬件与驱动信息。Windows 验证内置扬声器工作，并查明两个 USB-C 口的显示路由不同。
2. 使用诊断版 NVRMFB 和 5 秒轮询测试热插拔，最终使用第二个 USB-C 口接主屏，原生 HDMI 接右侧副屏。内屏的 OpenCore GOP 分辨率设为 2560×1600。macOS 刷新率由系统和驱动协商。
3. 编译 itlwm 后以终端确认 AX211 可扫描、关联并取得 DHCP。修正 HeliPort 菜单后，进一步切换到 Tahoe 版 AirportItlwm，重启后验证原生 Wi-Fi 开关。
4. 双 CS35L41 通过 SPI 返回 0x00035A40。Windows G814JV 的 1043:1CCF 配置提供匹配的 B2 固件和调音文件。分别确认复位、上传、校准与 DSP 初始化。CirrusAudioFixup 增加本机 NMXAudio 内置输出识别后，双功放在测试中进入 PLAYBACK_ACTIVE，用户确认实际出声。
5. Chrome 全窗口白闪伴随 GPU 进程崩溃，macOS 记录 SIGTRAP。完全关闭加速后白闪消失但掉帧明显。独立配置下保留 GPU 合成、只关闭硬件视频解码，共两轮零 GPU 崩溃，其中一段 1080p30 连续 1031 帧无新增掉帧。H.264 对照时缓冲耗尽，编码本身的影响仍未判定。
