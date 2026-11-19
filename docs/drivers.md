# 驱动来源与构建

| 组件 | 来源与定位 | 安装位置 |
| --- | --- | --- |
| AirportItlwm 2.4.0 | [AirportItlwm-AX211](https://github.com/ElicoftZ/AirportItlwm-AX211/tree/030ef90b17d3d99a12f4415fec66f063dff111a5)，Tahoe x86_64，AX211 8086:7A70 | OpenCore EFI |
| CirrusAudioFixup 1.2.0 | [CirrusAudioFixup](https://github.com/hoaug-tran/CirrusAudioFixup/tree/8b5cad5454e8a9d420c866406ce421b256dab343)，搭配归档补丁 | OpenCore EFI |
| NVRMFB、NVRM、NVAccel、NVRMAGDC、NMXAudio | 本机 NullMoth 套件，NVRMFB 使用已验证的诊断版本 | /Library/Extensions 与 AuxKC |
| itlwm / HeliPort | [itlwm](https://github.com/OpenIntelWireless/itlwm/tree/53c51c2cdd6e4b69beb91f310d74c53422b0f8bd) 和 [HeliPort](https://github.com/OpenIntelWireless/HeliPort)，备用路径 | 采用原生 Wi-Fi 时禁用 itlwm 注入 |

编译使用 Xcode 26.6，选择 x86_64 Release。AirportItlwm 使用对应源码的 Tahoe 目标。Cirrus 在对应提交应用 `patches/cirrus-g814.patch`，准备仓库所需的 Lilu 和 MacKernelSDK，再在本机应用受 Git 忽略的 `local-private/cirrus-firmware.patch`。OEM 固件来自已安装的 Windows 驱动，具体 INF 和文件路径见本机原始记录。构建命令如下。

```sh
xcodebuild -project CirrusAudioFixup.xcodeproj -target CirrusAudioFixup \
  -configuration Release -sdk macosx CODE_SIGNING_ALLOWED=NO build
```

使用 `dwarfdump --uuid 路径/Contents/MacOS/驱动名` 对照 `kmutil showloaded`。最终七个驱动 UUID 见本机清单。启用驱动后通过实际出画、Wi-Fi 操作、测试音验证对应功能。

本机源码、构建依赖和备用 itlwm 保存在 `local-private/rebuild/`。最终实测驱动与旧版回退分别见 `local-private/drivers/` 和 `local-private/rollback/`。历史构建及诊断日志见 `local-private/evidence/build-history/`。
