
# 项目背景

本仓库是 [mattpocock/skills](https://github.com/mattpocock/skills) 的 fork，用于维护该仓库 skills 的**中文翻译版本**。

采用「**方案A：文件级隔离**」策略：
- **不修改**任何上游英文原始文件（`.agents/`、`skills/`、`docs/`、根目录 `README.md`、`AGENTS.md`、`CLAUDE.md` 等），只做同步（sync fork / merge upstream），保持与上游一致。
- 所有中文翻译内容只放在独立的 `zh-CN/` 目录下，目录结构与 `skills/` 保持一一对应（例如 `skills/engineering/ask-matt/SKILL.md` 对应翻译文件 `zh-CN/skills/engineering/ask-matt/SKILL.md`）。
- 翻译进度、状态清单记录在 `zh-CN/README.md` 中。
- 根目录另有 `README.zh-CN.md`，用于说明整体的中文维护策略。

# 翻译规范

1. 只翻译文字内容，不改动原始英文文件。
2. 术语、代码块、命令行示例、frontmatter 字段名等保持原样，不做翻译（如涉及专有名词，如 "skill"、"grill"、"TDD" 等，需要在项目内保持一致的翻译/不翻译选择）。
3. 每个 `SKILL.md` 翻译文件**必须**在 frontmatter 内注明对应英文原文件最近一次改动的完整 commit SHA，key 名 `commit_version`（多出的字段会被 skill loader 忽略，不影响解析）。源文件路径由 `zh-CN/` 与 `skills/` 的一一对应关系推导，无需记录；`README.md`、`openai.yaml` 等其他文件不记录。SHA 取 `git log -1 --format=%H -- <源文件路径>`（`<源文件路径>` 即去掉 `zh-CN/` 前缀后的路径）。完整规范见 `zh-CN/README.md`。
4. 翻译完成后，务必同步更新 `zh-CN/README.md` 中的翻译状态清单。
5. 全新增加的 skill 文件 → 需要完整翻译；只有局部文字改动的 → 只需要更新对应改动的段落，保持已有翻译风格、术语一致，不要整篇重翻。
6. 纯格式/链接更新等无实质内容变化的改动，可以跳过或简单处理。

# 上游同步机制（三阶段流程）

**阶段1（已完成，自动运行）**：`.github/workflows/check-upstream.yml`
- 每天 UTC 00:00 定时运行 + 支持手动 `workflow_dispatch`
- 检测 `mattpocock/skills` 的 `main` 分支是否有新 commit
- 有新 commit 时自动创建一个 `upstream-sync` 标签的 Issue，汇总新增 commit 列表、涉及的 `skills/` 目录改动文件、全部改动文件清单
- 创建前会判重（避免同一 upstream SHA 重复开 Issue）

**阶段2（人工执行）**：收到阶段1的 Issue 通知后，人工通过 GitHub 网页 "Sync fork" 按钮（或 `git fetch upstream && git merge upstream/main`）将上游改动同步到本仓库 `main` 分支。

**阶段3（人工触发 + Coding Agent 执行）**：同步完成后，针对阶段1 Issue 中列出的、位于 `skills/` 目录下的改动文件，分析改动类型（全新文件 / 局部修改 / 纯格式），生成翻译任务，更新 `zh-CN/` 目录下对应的翻译文件，并同步更新 `zh-CN/README.md` 的翻译状态清单。

# ⚠️ 编写 GitHub Actions workflow 时的重要注意事项（踩过的坑）

1. **禁止在 `run:` 脚本中直接拼接 `${{ steps.xxx.outputs.yyy }}` 作为 shell 字符串赋值或命令的一部分**，尤其是内容来自 git log / commit message 等不可控外部输入的场合。这是脚本注入风险：`${{ }}` 在脚本执行前就做纯文本替换，如果 output 内容里包含反引号、双引号、`$` 等 shell 特殊字符，会被错误地解析为 shell 语法（曾经因为 commit message 中的反引号导致 "command not found" 报错）。
   - **正确做法**：一律通过该 step 的 `env:` 块传入，再在脚本里用 `"$VAR_NAME"` 引用（双引号包裹）。
   - `if:` 条件表达式里使用 `${{ steps.xxx.outputs.yyy == 'xxx' }}` 这种布尔判断是安全的，不受此规则限制。
2. **多行字符串拼接（heredoc / block literal）时要注意 YAML 缩进**：`run: |` 这种块字面量要求块内所有内容行的缩进都必须大于等于该块起始行的缩进，一旦某一行顶格或缩进不足，YAML 解析器会提前"截断"该块，导致语法错误且难以定位。
   - 涉及生成大段 Markdown 正文（如 Issue body）时，优先使用 `cat > /tmp/xxx.md <<'EOF' ... EOF`（写入临时文件）+ `gh issue create --body-file` 的方式，而不是把大段格式化文本塞进一个 shell 变量的双引号字符串里。
3. **workflow 的 `name:` 字段无法被正确解析时**，GitHub Actions 页面会用文件路径代替显示名称——这通常是 YAML 语法错误的连带症状，而不是独立问题，修复语法错误后名称会自动恢复正常。
4. 提交/合并新增的 workflow 后，请务必手动触发一次（`workflow_dispatch`）或观察一次真实运行结果，确认没有语法错误、权限错误（例如 Issues 功能是否开启：`has_issues` 需要为 `true`，否则 `gh issue create` 会报 "the repository has disabled issues"）。
5. 本仓库根目录下的 `.github/workflows/release.yml` 是上游 `mattpocock/skills` 自带的发布流程（基于 changesets，用于 npm 包发布），fork 过来后大概率会失败（缺少发布权限/上下文），**这是预期行为，不需要修复，也不需要删除**（删除后下次 sync fork 又会带回来），可以忽略其失败状态。

# 关于 Coding Agent 使用的建议

- 发起 Coding Agent 任务前，应尽量先给出清晰、详细、可执行的任务描述，包含背景、根本原因分析（如果是 bug 修复）、明确的验收标准。
- 修复类任务应要求 Coding Agent 检查**整个文件**中是否存在同类问题，一次性修复干净，而不是只改报错的那一处。
- 涉及安全隐患的修复（如脚本注入），应要求 Coding Agent 自行推演验证边界情况（例如内容包含特殊字符时的行为）。
