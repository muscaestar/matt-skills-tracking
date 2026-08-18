# Issue 跟踪器：GitHub

本仓库的 issue 和规格以 GitHub issue 的形式存放。所有操作使用 `gh` CLI。

## 约定

- **创建 issue**：`gh issue create --title "..." --body "..."`。多行正文使用 heredoc。
- **阅读 issue**：`gh issue view <number> --comments`，用 `jq` 过滤评论，同时获取标签。
- **列出 issue**：`gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`，并搭配适当的 `--label` 和 `--state` 过滤器。
- **评论 issue**：`gh issue comment <number> --body "..."`
- **添加 / 移除标签**：`gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **关闭**：`gh issue close <number> --comment "..."`

从 `git remote -v` 推断仓库——在 clone 内运行时 `gh` 会自动完成。

## 将 Pull Request 作为 triage 来源

**PRs as a request surface: no.** _（如果本仓库把外部 PR 视为功能请求，设为 `yes`；`/triage` 会读取这个开关。）_

设为 `yes` 时，PR 与 issue 走同样的标签和状态流程，使用对应的 `gh pr` 命令：

- **阅读 PR**：`gh pr view <number> --comments`，diff 用 `gh pr diff <number>`。
- **列出待 triage 的外部 PR**：`gh pr list --state open --json number,title,body,labels,author,authorAssociation,comments`，然后只保留 `authorAssociation` 为 `CONTRIBUTOR`、`FIRST_TIME_CONTRIBUTOR` 或 `NONE` 的（丢弃 `OWNER`/`MEMBER`/`COLLABORATOR`）。
- **评论 / 打标签 / 关闭**：`gh pr comment`、`gh pr edit --add-label`/`--remove-label`、`gh pr close`。

GitHub 的 issue 和 PR 共用一个编号空间，所以单独的 `#42` 可能是任意一种——用 `gh pr view 42` 解析，失败再退回 `gh issue view 42`。

## 当技能说"发布到 issue 跟踪器"时

创建一个 GitHub issue。

## 当技能说"获取相关 ticket"时

运行 `gh issue view <number> --comments`。

## Wayfinding 操作

供 `/wayfinder` 使用。**map** 是单个 issue，**child** issue 即 ticket。

- **Map**：一个带 `wayfinder:map` 标签的 issue，正文为 Notes / Decisions-so-far / Fog。`gh issue create --label wayfinder:map`。
- **Child ticket**：通过 GitHub sub-issue 关联到 map 的 issue（在 sub-issues 端点上用 `gh api`）。在未启用 sub-issues 的地方，把 child 加入 map 正文中的任务列表，并在 child 正文顶部写上 `Part of #<map>`。标签：`wayfinder:<type>`（`research`/`prototype`/`grilling`/`task`）。被认领后，ticket 指派给主导的开发者。
- **阻塞**：GitHub 的**原生 issue 依赖**——规范的、UI 可见的表示。添加一条边：`gh api --method POST repos/<owner>/<repo>/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>`，其中 `<blocker-db-id>` 是阻塞方的数字 **database id**（`gh api repos/<owner>/<repo>/issues/<n> --jq .id`，_不是_ `#number` 或 `node_id`）。GitHub 会报告 `issue_dependencies_summary.blocked_by`（仅未关闭的阻塞方——实时的门槛）。在依赖不可用的地方，退回为在 child 正文顶部写一行 `Blocked by: #<n>, #<n>`。当所有阻塞方都关闭时，ticket 即解除阻塞。
- **Frontier 查询**：列出 map 的未关闭 child（`gh issue list --state open`，限定在 map 的 sub-issues / 任务列表范围内），丢弃任何有未关闭阻塞方（`issue_dependencies_summary.blocked_by > 0`，或 `Blocked by` 行中有未关闭 issue）或已有指派人的；按 map 顺序取第一个。
- **认领**：`gh issue edit <n> --add-assignee @me`——会话的第一次写入。
- **解决**：`gh issue comment <n> --body "<answer>"`，然后 `gh issue close <n>`，再向 map 的 Decisions-so-far 追加上下文指针（gist + 链接）。
