---
name: retro
description: "对一次编码会话进行复盘。"
disable-model-invocation: true
commit_version: a7d038f6bf7f01b516408e95e2fb56e0b338fa6f
---

用户要求进行**复盘（retrospective）**。你要为编码 agent 的**环境**提出改进建议，以改善未来的运行。

## 步骤

1. 调用 Skill 工具获取 `writing-for-agents`，查看写作风格指南。

2. 阅读用户指定会话的一手来源。这可能意味着要在这台机器上搜索会话日志。如果用户没有指定会话，默认使用当前会话。

3. 在以下类别中寻找改进候选。

- **导航（Navigation）**：agent 找到正确文件有多容易？文件之间是否存在隐藏的依赖？一个**导航指针（navigation pointer）**会让事情更容易吗？_适用时机_：会话花了很长时间才找到某条信息。
- **自动化检查（Automated checks）**：是否有自动化检查能抓住 agent 犯下的错误？Lint、类型检查、测试、文件系统 linter？先读仓库自己的检查命令（它的 `package.json`/构建工具的 `lint`/`check` 脚本、它的 CI workflow），这样发现就是一个"已存在但没接线或悄悄坏掉的检查"，而不是重复发明。一个没有任何**护栏（guardrail）**（没有 pre-commit 钩子、也没有 CI job 运行它的 lint/类型检查/测试命令）的仓库本身就是一个发现：一个不做 lint 的仓库是一个长期被错过的机会，而不是中性的默认状态。_适用时机_：agent 犯了一个自动化检查本可以抓住的错误，或仓库完全没有任何护栏。
- **编码标准（Coding standards）**：是否应该给 **reviewer agent** 一条新规则去执行？是否应该移除或澄清一条现有规则？先对违规进行分类：**机械性（mechanical）**违规（固定的语法模式、被禁用的 API、import 形态、文件位置规则）得到一个确定性检查，仅此而已：仓库自己 linter 里的一条自定义规则、一个新的 pre-commit 钩子、或一个新的 CI job，看仓库的语言和现有护栏哪个最便宜。默认构建检查，而不是写规则。把 `CODING_STANDARDS.md` 留给真正的**判断题（judgement calls）**（跨文件一致性、"与周围风格匹配"、任何护栏永远无法替代的东西）。_适用时机_：reviewer agent 没能抓到一个错误。
- **全局 AGENTS.md**：是否有任何引导指令应该移到编码标准（或自动化检查）里？_适用时机_：AGENTS.md 文件特别大——在仓库里或在用户全局范围内。
- **工具经济（Tool economy）**：agent 是否做了可以精简的昂贵工具调用？是否有任何自定义工具（CLI、MCP）特别浪费 token？_适用时机_：agent 做了一次昂贵的工具调用。
- **无操作（No-ops）**：寻找引导文件中不改变 agent 行为的指令。_适用时机_：引导文件又大又难管。
- **信息获取（Information access）**：寻找能增加 agent 信息获取能力的机会。把 dev server 日志 tee 出来、对第三方服务的只读访问。_适用时机_：agent 拿不到某条关键信息。

4. 按严重程度排序，把这些候选呈现给用户。

## 参考

### 实现 vs 审查

记住，所有工作都经过两个阶段：实现和审查。实现 agent 承受的**上下文压力**最大。它们负责探索、写代码、调试失败。

审查 agent 的上下文压力最小——它收到的是一个 diff，无需探索。它通常不需要写代码或调试。

这意味着应该由审查 agent 负责执行编码标准，而不是实现 agent。

### 文件

你可以访问仓库中的几个文件：

- `CLAUDE.md`/`AGENTS.md`：这些文件会被推送到任何在此仓库工作的 agent 的上下文窗口。应当极其节俭地使用它们，通常只用于指向其他文件的**导航指针**。
- `CODING_STANDARDS.md`：这个文件在审查时阅读，而不是实现时。如果标准文件超过 1000 行，就添加指向 docs 文件夹的**导航指针**。
- Docs：把 docs 用作参考文件，由其他文件指向它们。写新文档之前先找已有的。
- Skills：把 skill 用作文档（因为它们的 description 会进入 agent 的上下文窗口），或作为用户调用的命令。遵循 `writing-for-agents` skill 的建议。
