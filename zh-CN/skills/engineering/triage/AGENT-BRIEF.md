---
commit_version: e00eadb4bb32c3d5a631ead1a5ed5d6a7c5f74e2
---

# 撰写 Agent 简报

Agent 简报是当 issue 或 PR 移动到 `ready-for-agent` 时发布在其上的一条结构化评论。它是 AFK agent 将据以工作的权威规格。原始正文和讨论是上下文——agent 简报才是契约。

简报陈述 **agent 应该做什么**，这延伸到两种来源：对于 issue，是从零构建改动；对于 PR，是*对现有 diff* 还剩什么要做——完成它、补上缺口、处理审查意见。无论哪种，原则相同；下面的 PR 示例展示了差异。

## 原则

### 耐久性优先于精确性

Issue 可能在 `ready-for-agent` 状态停留数天或数周。代码库在此期间会变化。撰写简报时，要让它即使在文件被重命名、移动或重构后依然有用。

- **要**描述接口、类型和行为契约
- **要**点名 agent 应该查找或修改的具体类型、函数签名或配置形状
- **不要**引用文件路径——它们会过时
- **不要**引用行号
- **不要**假设当前的实现结构会保持不变

### 行为化，而不是步骤化

描述系统**应该做什么**，而不是**怎么实现**。agent 会从头探索代码库，自己做出实现决策。

- **好：** "`SkillConfig` 类型应该接受一个类型为 `CronExpression` 的可选 `schedule` 字段"
- **坏：** "打开 src/types/skill.ts，在第 42 行加一个 schedule 字段"
- **好：** "当用户不带参数运行 `/triage` 时，应该看到一份需要关注的 issue 摘要"
- **坏：** "在主处理函数里加一个 switch 语句"

### 完整的验收标准

Agent 需要知道什么时候算完成。每份 agent 简报必须有具体、可测试的验收标准。每条标准都应可独立验证。

- **好：** "运行 `gh issue list --label needs-triage` 返回的是已经过初始分类的 issue"
- **坏：** "Triage 应该能正常工作"

### 显式的范围边界

声明什么在范围之外。这可以防止 agent 镀金（gold-plating）或对相邻功能做假设。

## 模板

> 模板和示例中的简报正文保留英文——简报是写给 agent 的规格，按仓库的工作语言撰写；各小节的含义见下方中文说明。

```markdown
## Agent Brief

**Category:** bug / enhancement    # 类别
**Summary:** one-line description of what needs to happen    # 摘要：一句话描述要做什么

**Current behavior:**    # 当前行为
Describe what happens now. For bugs, this is the broken behavior.
For enhancements, this is the status quo the feature builds on.
（描述现在的情况。对 bug 来说，就是坏掉的行为；对 enhancement 来说，是该功能赖以建立的现状。）

**Desired behavior:**    # 期望行为
Describe what should happen after the agent's work is complete.
Be specific about edge cases and error conditions.
（描述 agent 完成工作后应该发生什么。要具体说明边界情况和错误条件。）

**Key interfaces:**    # 关键接口
- `TypeName` — what needs to change and why    # 需要改什么、为什么
- `functionName()` return type — what it currently returns vs what it should return    # 现在返回什么 vs 应该返回什么
- Config shape — any new configuration options needed    # 需要哪些新配置项

**Acceptance criteria:**    # 验收标准
- [ ] Specific, testable criterion 1    # 具体、可测试的标准 1
- [ ] Specific, testable criterion 2
- [ ] Specific, testable criterion 3

**Out of scope:**    # 范围之外
- Thing that should NOT be changed or addressed in this issue    # 本 issue 中不应改动或处理的事情
- Adjacent feature that might seem related but is separate    # 看似相关但实则独立的相邻功能
```

## 示例

### 好的 agent 简报（bug）

```markdown
## Agent Brief

**Category:** bug
**Summary:** Skill description truncation drops mid-word, producing broken output
（摘要：skill 描述截断在单词中间断开，产生残缺的输出）

**Current behavior:**
When a skill description exceeds 1024 characters, it is truncated at exactly
1024 characters regardless of word boundaries. This produces descriptions
that end mid-word (e.g. "Use when the user wants to confi").
（当前行为：当 skill 描述超过 1024 个字符时，无论是否处于单词边界，都恰好截断在
1024 个字符处。这导致描述在单词中间结束（例如 "Use when the user wants to confi"）。）

**Desired behavior:**
Truncation should break at the last word boundary before 1024 characters
and append "..." to indicate truncation.
（期望行为：截断应该在 1024 个字符之前的最后一个单词边界处断开，
并追加 "..." 以表示发生了截断。）

**Key interfaces:**
- The `SkillMetadata` type's `description` field — no type change needed,
  but the validation/processing logic that populates it needs to respect
  word boundaries
（`SkillMetadata` 类型的 `description` 字段——类型不需要改，
  但填充它的校验/处理逻辑需要尊重单词边界）
- Any function that reads SKILL.md frontmatter and extracts the description
（任何读取 SKILL.md frontmatter 并提取描述的函数）

**Acceptance criteria:**
- [ ] Descriptions under 1024 chars are unchanged    # 1024 字符以内的描述保持不变
- [ ] Descriptions over 1024 chars are truncated at the last word boundary
      before 1024 chars    # 超过 1024 字符的描述在 1024 字符之前的最后一个单词边界处截断
- [ ] Truncated descriptions end with "..."    # 被截断的描述以 "..." 结尾
- [ ] The total length including "..." does not exceed 1024 chars    # 含 "..." 的总长度不超过 1024 字符

**Out of scope:**
- Changing the 1024 char limit itself    # 改动 1024 字符上限本身
- Multi-line description support    # 多行描述支持
```

### 好的 agent 简报（enhancement）

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Add `.out-of-scope/` directory support for tracking rejected feature requests
（摘要：新增 `.out-of-scope/` 目录支持，用于追踪被拒绝的功能请求）

**Current behavior:**
When a feature request is rejected, the issue is closed with a `wontfix` label
and a comment. There is no persistent record of the decision or reasoning.
Future similar requests require the maintainer to recall or search for the
prior discussion.
（当前行为：功能请求被拒绝时，issue 打上 `wontfix` 标签、附一条评论就被关闭。
决定及其理由没有持久记录。以后出现类似请求时，维护者只能靠回忆
或搜索之前的讨论。）

**Desired behavior:**
Rejected feature requests should be documented in `.out-of-scope/<concept>.md`
files that capture the decision, reasoning, and links to all issues that
requested the feature. When triaging new issues, these files should be
checked for matches.
（期望行为：被拒绝的功能请求应记录在 `.out-of-scope/<concept>.md` 文件中，
内容涵盖决定、理由，以及所有请求过该功能的 issue 链接。
triage 新 issue 时，应检查这些文件是否有匹配。）

**Key interfaces:**
- Markdown file format in `.out-of-scope/` — each file should have a
  `# Concept Name` heading, a `**Decision:**` line, a `**Reason:**` line,
  and a `**Prior requests:**` list with issue links
（`.out-of-scope/` 中的 Markdown 文件格式——每个文件应有一个
  `# Concept Name` 标题、一行 `**Decision:**`、一行 `**Reason:**`，
  以及一个带 issue 链接的 `**Prior requests:**` 列表）
- The triage workflow should read all `.out-of-scope/*.md` files early
  and match incoming issues against them by concept similarity
（triage 工作流应尽早读取所有 `.out-of-scope/*.md` 文件，
  并按概念相似度将新进来的 issue 与它们匹配）

**Acceptance criteria:**
- [ ] Closing a feature as wontfix creates/updates a file in `.out-of-scope/`    # 以 wontfix 关闭功能请求时，会在 `.out-of-scope/` 中创建/更新文件
- [ ] The file includes the decision, reasoning, and link to the closed issue    # 文件包含决定、理由和被关闭 issue 的链接
- [ ] If a matching `.out-of-scope/` file already exists, the new issue is
      appended to its "Prior requests" list rather than creating a duplicate
      （如果已存在匹配的 `.out-of-scope/` 文件，新 issue 追加到其
      "Prior requests" 列表，而不是创建重复文件）
- [ ] During triage, existing `.out-of-scope/` files are checked and surfaced
      when a new issue matches a prior rejection
      （triage 期间会检查现有 `.out-of-scope/` 文件，并在新 issue
      与之前的拒绝匹配时浮现出来）

**Out of scope:**
- Automated matching (human confirms the match)    # 自动匹配（匹配由人确认）
- Reopening previously rejected features    # 重新打开之前被拒绝的功能
- Bug reports (only enhancement rejections go to `.out-of-scope/`)    # bug 报告（只有 enhancement 的拒绝进入 `.out-of-scope/`）
```

### 好的 agent 简报（PR）

对于 PR，"Current behavior" 描述的是 diff 的现状，简报要求 agent 完成或修复它，而不是从零构建。

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Finish the contributor's `--json` output flag for `triage list`
（摘要：完成贡献者为 `triage list` 添加的 `--json` 输出标志）

**Current behavior:**
The PR adds a `--json` flag that serializes the issue list to JSON. The happy
path works and the diff matches the project's command structure. Two gaps
remain: errors are still printed as human text (not JSON), and the new flag has
no test coverage.
（当前行为：该 PR 添加了一个将 issue 列表序列化为 JSON 的 `--json` 标志。
顺利路径可用，diff 也符合项目的命令结构。还剩两个缺口：
错误仍以人类可读文本（而非 JSON）打印，且新标志没有测试覆盖。）

**Desired behavior:**
With `--json`, all output — including errors — is well-formed JSON on stdout,
and the command's exit codes are unchanged. The existing human-readable output
is untouched when the flag is absent.
（期望行为：使用 `--json` 时，所有输出——包括错误——都是 stdout 上
格式良好的 JSON，且命令的退出码保持不变。
不带该标志时，现有的人类可读输出完全不受影响。）

**Key interfaces:**
- The command's error path should emit `{ "error": string }` under `--json`
  instead of the plain-text error
（该命令的错误路径在 `--json` 下应输出 `{ "error": string }`，
  而不是纯文本错误）
- Reuse the existing serializer the PR already added; don't introduce a second
（复用 PR 已经添加的序列化器；不要再引入第二个）

**Acceptance criteria:**
- [ ] `triage list --json` emits valid JSON for both success and error cases    # `triage list --json` 在成功和出错两种情况下都输出合法 JSON
- [ ] Exit codes match the non-JSON command    # 退出码与非 JSON 命令一致
- [ ] A test covers the `--json` success output and one error case    # 有测试覆盖 `--json` 的成功输出和一个出错场景
- [ ] Default (non-JSON) output is byte-for-byte unchanged    # 默认（非 JSON）输出逐字节保持不变

**Out of scope:**
- Adding `--json` to any other command    # 给任何其他命令添加 `--json`
- Changing the JSON shape of the success payload the PR already defined    # 改动 PR 已定义的成功载荷的 JSON 结构
```

### 坏的 agent 简报

```markdown
## Agent Brief

**Summary:** Fix the triage bug    # 修复 triage 的 bug

**What to do:**    # 要做什么
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.
（triage 那东西坏了。看一下主文件，把它修好。
大约第 150 行附近的函数有问题。）

**Files to change:**    # 要改的文件
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

它坏在哪里：
- 没有类别
- 描述含糊（"the triage thing is broken"——triage 那东西坏了）
- 引用了会过时的文件路径和行号
- 没有验收标准
- 没有范围边界
- 没有描述当前行为与期望行为
