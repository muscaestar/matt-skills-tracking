---
name: setup-matt-pocock-skills
description: 为 engineering 技能配置本仓库——设置它的 issue 跟踪器、triage 标签词汇表和领域文档布局。在首次使用其他 engineering 技能之前运行一次。
disable-model-invocation: true
commit_version: c66bdeeee002d81e3f8b21403c07f9a0d7bea6da
---

# Setup Matt Pocock's Skills

搭建 engineering 技能所依赖的仓库级配置：

- **Issue 跟踪器**——issue 存放在哪里（默认 GitHub；也开箱支持本地 markdown）
- **Triage 标签**——五个标准 triage 角色使用的标签字符串
- **领域文档**——`CONTEXT.md` 和 ADR 存放在哪里，以及阅读它们的消费方规则

这是一个提示词驱动的技能，不是确定性脚本。先探索，展示你的发现，与用户确认，然后再写入。

## 流程

### 1. 探索

查看当前仓库以了解其初始状态。读取已存在的一切；不要假设：

- `git remote -v` 和 `.git/config`——这是 GitHub 仓库吗？是哪一个？
- 仓库根目录的 `AGENTS.md` 和 `CLAUDE.md`——是否存在？其中是否已经有 `## Agent skills` 小节？
- 仓库根目录的 `CONTEXT.md` 和 `CONTEXT-MAP.md`
- `docs/adr/` 以及任何 `src/*/docs/adr/` 目录
- `docs/agents/`——本技能之前的输出是否已经存在？
- `.scratch/`——标志着本地 markdown issue 跟踪器约定已在使用的迹象
- 是否安装了 `triage` 技能？（与本技能并列的 `triage` 技能文件夹，或你的可用技能中有 `triage`。）这决定 Section B 是否会运行。
- Monorepo 信号——`pnpm-workspace.yaml`、`package.json` 中的 `workspaces` 字段，或拥有自己 `src/` 的充实的 `packages/*`。只有在真正大型的多包仓库中才会出现；它们的缺失意味着单上下文（single-context），这几乎是所有仓库的情况。

### 2. 展示发现并提问

总结什么已存在、什么缺失。然后按顺序逐个处理各小节——一个小节、一个答案，然后下一个。

每个小节都先给出推荐答案，让用户一个字就能接受。只有当选择真正产生分支时才给出一行解释；当探索已经得出结论时，整个小节直接跳过（`triage` 未安装时跳过 Section B，没有 monorepo 时跳过 Section C）。

**Section A — Issue 跟踪器。**

> 解释："Issue 跟踪器"是本仓库 issue 存放的地方。`to-tickets`、`triage`、`to-spec` 等技能会对它读写——它们需要知道是该调用 `gh issue create`、在 `.scratch/` 下写 markdown 文件，还是遵循你描述的其他工作流。选择你实际用来跟踪本仓库工作的那个地方。

默认立场：这些技能是为 GitHub 设计的。如果 `git remote` 指向 GitHub，就提议 GitHub。如果 `git remote` 指向 GitLab（`gitlab.com` 或自托管实例），就提议 GitLab。否则（或用户更想要的话），提供：

- **GitHub**——issue 存放在仓库的 GitHub Issues 中（使用 `gh` CLI）
- **GitLab**——issue 存放在仓库的 GitLab Issues 中（使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI）
- **本地 markdown**——issue 以文件形式存放在本仓库的 `.scratch/<feature>/` 下（适合个人项目或没有 remote 的仓库）
- **其他**（Jira、Linear 等）——请用户用一段话描述工作流；技能会把它记录为自由文本

把选择记录到 `docs/agents/issue-tracker.md`。GitHub 和 GitLab 模板带有一个"PRs as a request surface"开关，默认为**关**——保持关闭，不要主动提起；想把外部 PR 纳入 triage 队列的用户可以稍后自己在文件中打开这个开关。

**Section B — Triage 标签词汇表。** 如果 `triage` 技能未安装（探索阶段已经告诉你），整个小节直接跳过——未安装的技能不需要标签。

如果已安装，只问一个问题：

> 你想保留默认的 triage 标签吗？（推荐：**是**）

默认值是五个标准角色，每个标签字符串与其名称相同：`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`。回答**是**就原样写入。只有当用户说不要时——通常是因为他们的跟踪器已经在用其他名字（例如用 `bug:triage` 代替 `needs-triage`）——才收集覆盖项，让 `triage` 应用已有标签而不是创建重复标签。

**Section C — 领域文档。** 默认采用**单上下文（single-context）**——仓库根目录一个 `CONTEXT.md` + `docs/adr/`。这适合几乎所有仓库；不用问，直接写入。

只有当探索发现了 monorepo 信号时，才提供**多上下文（multi-context）**——根目录一个 `CONTEXT-MAP.md`，指向每个上下文各自的 `CONTEXT.md` 文件。然后确认他们想要哪种布局。

### 3. 确认并编辑

向用户展示以下内容的草稿：

- 要添加到 `CLAUDE.md` / `AGENTS.md` 中被编辑的那个文件的 `## Agent skills` 块（选择规则见第 4 步）
- `docs/agents/issue-tracker.md`、`docs/agents/domain.md` 和 `docs/agents/triage-labels.md` 的内容（最后一个仅当 `triage` 已安装时）

让他们在写入前先编辑。

### 4. 写入

**选择要编辑的文件：**

- 如果 `CLAUDE.md` 存在，编辑它。
- 否则如果 `AGENTS.md` 存在，编辑它。
- 如果两者都不存在，问用户要创建哪一个——不要替他们选。

当 `CLAUDE.md` 已存在时永远不要创建 `AGENTS.md`（反之亦然）——始终编辑已经在那里的那个。

如果所选文件中已存在 `## Agent skills` 块，就地更新其内容，而不是追加一个重复的块。不要覆盖用户对周围小节的编辑。

该块内容：

```markdown
## Agent skills

### Issue tracker

[一句话总结 issue 跟踪在哪里]。See `docs/agents/issue-tracker.md`.

### Triage labels

[一句话总结标签词汇表]。See `docs/agents/triage-labels.md`.

### Domain docs

[一句话总结布局——"single-context" 或 "multi-context"]。See `docs/agents/domain.md`.
```

仅当 `triage` 已安装且 Section B 运行过时，才包含 `### Triage labels` 子块并写入 `docs/agents/triage-labels.md`。否则两者都省略。

然后以本技能文件夹中的种子模板为起点写入文档文件：

- [issue-tracker-github.md](./issue-tracker-github.md)——GitHub issue 跟踪器
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)——GitLab issue 跟踪器
- [issue-tracker-local.md](./issue-tracker-local.md)——本地 markdown issue 跟踪器
- [triage-labels.md](./triage-labels.md)——标签映射（仅当 `triage` 已安装时）
- [domain.md](./domain.md)——领域文档消费方规则 + 布局

对于"其他"类 issue 跟踪器，根据用户的描述从零开始编写 `docs/agents/issue-tracker.md`。

### 5. 完成

告诉用户配置已完成，以及哪些 engineering 技能现在会读取这些文件。提醒他们之后可以直接编辑 `docs/agents/*.md`——只有想更换 issue 跟踪器或从头重来时才需要重新运行本技能。
