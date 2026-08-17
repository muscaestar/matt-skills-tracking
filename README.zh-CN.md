# matt-skills-tracking（中文维护版）

> 本仓库是 [mattpocock/skills](https://github.com/mattpocock/skills) 的 **非官方中文维护 Fork**，遵循原仓库的 [MIT License](./LICENSE)。

原仓库简介：**Skills for Real Engineers** —— Matt Pocock 每天用于真实工程开发（而非 vibe coding）的 AI Agent 技能集合，可配合 Claude Code、Codex 等编码 Agent 使用。

## 本仓库的定位

本仓库的目标是：

1. **跟随上游更新**：定期同步 [mattpocock/skills](https://github.com/mattpocock/skills) 的最新改动（通过 GitHub 的 Sync Fork / merge upstream）。
2. **维护中文翻译**：在独立的 [`zh-CN/`](./zh-CN/README.md) 目录下，为各个 skill 提供逐字翻译的中文版本，方便中文用户理解和使用。
3. **同步上游改动通知**：后续会通过自动化流程（GitHub Actions）检测上游是否有新的 commit / 版本发布，并生成清单，标注哪些内容需要更新翻译。

## 同步策略（方案A：文件级隔离）

为了避免翻译内容与上游更新产生合并冲突，本仓库采用以下策略：

- **英文原始文件保持不动**：仓库根目录下的 `.agents/`、`skills/`、`AGENTS.md`、`CLAUDE.md`、`README.md` 等文件与上游内容完全一致，只做同步，不做任何修改。
- **中文翻译独立存放**：所有中文翻译内容统一放在 [`zh-CN/`](./zh-CN/README.md) 目录下，目录结构与英文原始结构一一对应。
- **好处**：上游更新时可以直接 merge，几乎不会产生冲突；翻译内容的更新与上游代码的同步互不干扰，各自独立维护。

## 当前进度

- [x] Fork 仓库，确认 MIT License 允许二次分发与翻译
- [x] 搭建 `zh-CN/` 目录及基础说明文档
- [ ] 搭建上游更新自动检测（GitHub Actions）
- [ ] 首次同步上游最新代码
- [ ] 逐个 skill 分类，起草中文翻译 PR

详细计划见 [`zh-CN/README.md`](./zh-CN/README.md) 中的翻译状态清单。

## 原始项目信息

- 上游仓库：https://github.com/mattpocock/skills
- 作者：[Matt Pocock](https://github.com/mattpocock)
- License：MIT
- 官网：https://aihero.dev/skills
