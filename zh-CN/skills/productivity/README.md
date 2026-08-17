# Productivity（效率）

通用工作流工具，不特定于代码。

## 用户调用

仅当你主动输入时可触发（Claude Code：`disable-model-invocation: true`；Codex：`agents/openai.yaml` 中的 `policy.allow_implicit_invocation: false`）。

- **[grill-me](./grill-me/SKILL.md)** — 对一个计划或设计进行毫不留情的追问，直到设计树的每个分支都被厘清。
- **[handoff](./handoff/SKILL.md)** — 将当前对话压缩为一份交接文档，以便另一个 agent 继续这项工作。
- **[teach](./teach/SKILL.md)** — 利用当前目录作为有状态的教学工作区，在多个会话中向用户教授一项新技能或概念。
- **[to-questionnaire](./to-questionnaire/SKILL.md)** — 把一个你无法独自回答的决策，转化为一份写给唯一能回答之人的 Markdown 问卷——可以异步填写，也可以在会议中一起完成。
- **[wait-what](./wait-what/SKILL.md)** — 一旦某条消息没有说清楚，立刻调用它。agent 会用你缺失的上下文、清晰直白的英语，并结合你的 `CONTEXT.md` 词汇，重新讲一遍。

## 模型调用

模型或用户都可触发（提供丰富的触发措辞，让模型也会主动使用它们）。

- **[grilling](./grilling/SKILL.md)** — 围绕一个计划、决策或想法对用户进行毫不留情的追问，直到设计树的每个分支都被厘清。
- **[writing-for-agents](./writing-for-agents/SKILL.md)** — 为 agents 编写文档：技能、AGENTS.md/CLAUDE.md，以及任何 agent 会通过指针访问到的文档。
