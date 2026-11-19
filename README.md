# ROG Strix G18 G814JV 黑苹果修复归档

本项目记录 i9-13980HX、RTX 4060 Laptop、AX211 和 ALC294 / 双 CS35L41 在 macOS Tahoe 与 Windows 双系统上的修复过程。

| 项目 | 实测状态 |
| --- | --- |
| 外接显示 | 第二个 USB-C 口经 RTX 4060 出画，原生 HDMI 同时可用。靠近 HDMI 的第一个 USB-C 的视频输出在 Windows 下走 Intel 核显，macOS 视频输出未验证。 |
| Wi-Fi | AX211 原生 Wi-Fi 开关重启后可用。HeliPort 修订版作为 itlwm 备用方案。 |
| 内置扬声器 | 双功放进入播放，用户听到低音量测试音。 |
| Chrome | 默认加速复现 GPU 进程退出码 5。只关闭硬件视频解码时，两轮测试均无 GPU 崩溃。Safari 实测流畅，Chrome 长时间目测验收待完成。 |
| OpenCore | Recovery 已实测进入恢复工具。当前 EFI 已备份并校验，等待 10 秒。启动菜单实际排列待现场确认。 |

- [修复历程和验证证据](docs/history.md)
- [驱动来源、构建和验证](docs/drivers.md)
- [引导备份与恢复](docs/boot.md)
- [问题反馈模板](.github/ISSUE_TEMPLATE/diagnostics.md)

当前目录是 Git 仓库。第三方源码按各项目许可证使用。本机驱动包、原始日志、OEM 固件和 EFI 备份保存在 Git 忽略的 `local-private/` 下。上传前检查暂存清单。

Windows 调试原件单独备份在 `local-private/windows-debug/`。

公开发布参阅[上传步骤](docs/publish.md)和[来源与许可](NOTICE.md)。

[驱动下载、对应源码与校验值](downloads/README.md)
