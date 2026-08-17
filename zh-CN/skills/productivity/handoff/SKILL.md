---
name: handoff
description: 将当前对话压缩为一份交接文档，供另一个 agent 接手。
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
commit_version: d28dfdc39beadc3142a33359b5cfa4765dcbd0bc
---

写一份总结当前对话的交接文档，以便一个全新的 agent 可以继续这项工作。保存到用户操作系统的临时目录——而不是当前工作区。

在文档中加入一个“建议使用的技能”章节，说明下一个 agent 应该针对哪些技能调用 Skill 工具。

不要重复其他产物（规格说明、计划、ADR、issue、提交、diff）中已经记录的内容，改为通过路径或 URL 引用它们。

隐去任何敏感信息，例如 API 密钥、密码或个人身份信息。

如果用户传入了参数，把它们视为对下一次会话重点内容的描述，并据此定制文档。
