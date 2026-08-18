# Issue 跟踪器：GitLab

本仓库的 issue 和规格以 GitLab issue 的形式存放。所有操作使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- **创建 issue**：`glab issue create --title "..." --description "..."`。多行描述使用 heredoc。传 `--description -` 可打开编辑器。
- **阅读 issue**：`glab issue view <number> --comments`。用 `-F json` 获得机器可读输出。
- **列出 issue**：`glab issue list -F json`，搭配适当的 `--label` 过滤器。
- **评论 issue**：`glab issue note <number> --message "..."`。GitLab 把评论称为 "notes"。
- **添加 / 移除标签**：`glab issue update <number> --label "..."` / `--unlabel "..."`。多个标签可以用逗号分隔或重复该 flag。
- **关闭**：`glab issue close <number>`。`glab issue close` 不接受关闭评论，所以先用 `glab issue note <number> --message "..."` 发布说明，然后再关闭。
- **Merge requests**：GitLab 把 PR 称为 "merge requests"。使用 `glab mr create`、`glab mr view`、`glab mr note` 等——与 `gh pr ...` 形态相同，只是用 `mr` 代替 `pr`，用 `note`/`--message` 代替 `comment`/`--body`。

从 `git remote -v` 推断仓库——在 clone 内运行时 `glab` 会自动完成。

## 将 Merge Request 作为 triage 来源

**MRs as a request surface: no.** _（如果本仓库把外部 merge request 视为功能请求，设为 `yes`；`/triage` 会读取这个开关。）_

设为 `yes` 时，MR 与 issue 走同样的标签和状态流程，使用对应的 `glab mr` 命令：

- **阅读 MR**：`glab mr view <number> --comments`，diff 用 `glab mr diff <number>`。
- **列出待 triage 的外部 MR**：`glab mr list -F json`，然后只保留作者不是项目 member/owner 的 MR（贡献者的 MR，而不是维护者正在进行的工作）。
- **评论 / 打标签 / 关闭**：`glab mr note`、`glab mr update --label`/`--unlabel`、`glab mr close`。

与 GitHub 不同，GitLab 的 issue 和 MR 分开编号，所以一旦知道维护者指的是哪个来源，`#42` 就是没有歧义的。

## 当技能说"发布到 issue 跟踪器"时

创建一个 GitLab issue。

## 当技能说"获取相关 ticket"时

运行 `glab issue view <number> --comments`。

## Wayfinding 操作

供 `/wayfinder` 使用。**map** 是单个 issue，**child** issue 即 ticket。

- **Map**：一个带 `wayfinder:map` 标签的 issue，正文为 Notes / Decisions-so-far / Fog。`glab issue create --label wayfinder:map`。（在拥有原生 epic 的 GitLab 套餐上，map 也可以由 epic 承载；带标签的 issue 在所有套餐上都可用。）
- **Child ticket**：描述顶部写有 `Part of #<map>`、标签为 `wayfinder:<type>`（`research`/`prototype`/`grilling`/`task`）的 issue。被认领后，ticket 指派给主导的开发者。
- **阻塞**：GitLab 的**原生阻塞链接**——规范的、UI 可见的表示。通过以 note 形式发布的 `/blocked_by #<n>` 快速操作添加（`glab issue note <child> --message "/blocked_by #<blocker>"`）。原生阻塞链接是 Premium/Ultimate 功能；在免费套餐（或不可用的地方）退回为在描述顶部写一行 `Blocked by: #<n>, #<n>`。当所有阻塞方都关闭时，ticket 即解除阻塞。
- **Frontier 查询**：`glab issue list -F json`，限定在 map 的 child 范围内，丢弃任何有未关闭阻塞方——指向未关闭 issue 的原生 `blocked_by` 链接（`glab api projects/:id/issues/:iid/links`），或 `Blocked by` 行中有未关闭 issue——或已有指派人的；按 map 顺序取第一个。
- **认领**：`glab issue update <n> --assignee @me`——会话的第一次写入。
- **解决**：`glab issue note <n> --message "<answer>"`，然后 `glab issue close <n>`，再向 map 的 Decisions-so-far 追加上下文指针（gist + 链接）。
