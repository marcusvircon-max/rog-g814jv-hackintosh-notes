# OpenCore 引导备份与恢复

当前机器以内置磁盘的 EFI 分区 1401 引导。历史设备名为 disk0s1，执行磁盘操作前用 diskutil list 核对。启动菜单目标配置是 Windows 第一、macOS 第二、其余靠后，等待 10 秒。已从当前 EFI 核验 Timeout=10、ShowPicker=true、PickerMode=External、HideAuxiliary=false、GOP 2560×1600，且 Microsoft 启动文件存在。Entries 和 BlessOverride 均为空，单凭配置无法确认自动扫描的菜单排列。

当前 EFI 完整副本位于 `local-private/current-efi/`。原卷与副本逐文件对照通过，配置通过 plist 格式检查，启用的 kext 所引用文件均存在，AirportItlwm 与 Cirrus 二进制和归档一致。当前环境没有匹配版本的 ocvalidate。以下命令用于后续备份，请在归档目录中执行。

```sh
diskutil list
sudo diskutil mount readOnly disk0s1
ditto /Volumes/1401/EFI ./local-private/current-efi/EFI
diff -rq /Volumes/1401/EFI ./local-private/current-efi/EFI
plutil -lint ./local-private/current-efi/EFI/OC/config.plist
diskutil unmount disk0s1
```

另用匹配 OpenCore 版本的 ocvalidate 校验配置。记录启用的 Kernel Add、启动顺序和 Timeout。EFI 原件包含机器标识和启动文件，仅供本机还原。旧 EFI 与旧 AuxKC 备份在 `local-private/rollback/pre-driver/`，其用途是回退。显示驱动涉及 macOS 的 AuxKC，单独恢复 EFI 不会恢复该集合。

恢复前保留当前配置的备份，并确认可从 OpenCore 进入 Recovery。恢复时优先对照备份恢复受影响的配置或驱动，macOS 与 Windows 的引导文件分别核对。
