---
name: claude-handoff
description: 把当前对话交接给一个立即接手工作的全新后台 agent。
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
commit_version: d28dfdc39beadc3142a33359b5cfa4765dcbd0bc
---

为当前对话写一份交接摘要，让全新的 agent 能继续这项工作。不要保存它，而是启动一个以该摘要为提示词的后台 agent：`claude --bg --name "<descriptive name>" "<handoff summary>"`。它在当前工作目录中启动并立即返回；用户用 `claude agents` 管理它。

始终传 `-n`/`--name` 并附一个描述性名字（例如 `--name "Fix login bug"`）——它设置任务列表、会话选择器和终端标题中显示的显示名。

在摘要中包含一个 "suggested skills" 小节，点名下一个 agent 应该调用 Skill 工具获取哪些技能。

不要重复已经捕获在其他制品中的内容（规格、计划、ADR、issue、commit、diff）。用路径或 URL 引用它们。

遮盖任何敏感信息，比如 API 密钥、密码或个人可识别信息——摘要会成为 agent 的提示词。

如果用户传入了参数，把它们视为对下一个会话关注点的描述，并相应调整摘要。
