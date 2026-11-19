# 公开仓库发布

建议仓库名 `rog-g814jv-hackintosh-notes`。发布内容包括故障记录、构建与恢复说明、已核对来源的补丁和诊断脚本。本机 EFI、驱动二进制、Windows 原始报告、OEM 固件与回退资料均保存在 Git 忽略的 `local-private/` 中。保留本机归档的独立备份，公开仓库只能恢复已提交的文件。

在 GitHub 创建一个空仓库，然后在本目录执行以下命令。将远程地址替换成你的新仓库地址。

```sh
git add .github .gitattributes .gitignore README.md NOTICE.md CONTRIBUTING.md docs patches scripts
git diff --cached --name-only
git diff --cached --check
git commit -m "Archive ROG G814JV Hackintosh repair notes"
git branch -M main
git remote add origin https://github.com/OWNER/rog-g814jv-hackintosh-notes.git
git push -u origin main
```
