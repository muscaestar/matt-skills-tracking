# Issue 跟踪器：本地 Markdown

本仓库的 issue 和规格以 markdown 文件的形式存放在 `.scratch/` 中。

## 约定

- 每个功能一个目录：`.scratch/<feature-slug>/`
- 规格是 `.scratch/<feature-slug>/spec.md`
- 实现 issue 每个 ticket 一个文件，位于 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 开始编号——永远不要合并成单个 tickets 文件
- Triage 状态记录为每个 issue 文件顶部附近的一行 `Status:`（角色字符串见 `triage-labels.md`）
- 评论和对话历史追加到文件底部的 `## Comments` 标题下

## 当技能说"发布到 issue 跟踪器"时

在 `.scratch/<feature-slug>/` 下创建一个新文件（如有需要则创建目录）。

## 当技能说"获取相关 ticket"时

读取所引用路径下的文件。用户通常会直接传入路径或 issue 编号。

## Wayfinding 操作

供 `/wayfinder` 使用。**map** 是一个文件，**child** 每个 ticket 一个文件。

- **Map**：`.scratch/<effort>/map.md`——Notes / Decisions-so-far / Fog 正文。
- **Child ticket**：`.scratch/<effort>/issues/NN-<slug>.md`，从 `01` 开始编号，问题写在正文中。一行 `Type:` 记录 ticket 类型（`research`/`prototype`/`grilling`/`task`）；一行 `Status:` 记录 `claimed`/`resolved`。
- **阻塞**：顶部附近的一行 `Blocked by: NN, NN`。当它列出的每个文件都是 `resolved` 时，ticket 即解除阻塞。
- **Frontier**：扫描 `.scratch/<effort>/issues/`，找出未关闭、未阻塞、未认领的文件；按编号取第一个。
- **认领**：设为 `Status: claimed` 并在开始任何工作前保存。
- **解决**：在 `## Answer` 标题下追加答案，设为 `Status: resolved`，然后向 `map.md` 中 map 的 Decisions-so-far 追加上下文指针（gist + 链接）。
