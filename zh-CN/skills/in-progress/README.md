---
commit_version: 3ec8e2399438cd5603324df8263acf3b64cf69b8
---

# In Progress（进行中）

Beta。这些技能是故意公开的：试用它们，告诉我哪里会坏。在它们毕业进入稳定桶之前，它们被排除在插件和顶层 README 之外，没有文档页面，并且可能在没有预警的情况下变更或消失。

插件不会给你这些技能。直接安装单个技能：

```bash
npx skills@latest add mattpocock/skills --skill=<name>
```

- **[loop-me](./loop-me/SKILL.md)**：跨多个会话把自己追问成可实现的工作流规格，以当前目录作为有状态的工作区。用户调用。
- **[writing-beats](./writing-beats/SKILL.md)**：把文章塑造成一段由节拍构成的旅程，自选冒险风格。挑选一个起始节拍，只写那一拍，然后转向下一拍，直到文章抵达自然的终点。
- **[writing-fragments](./writing-fragments/SKILL.md)**：一场从你身上开采碎片（异构的写作小块）的 grilling 会话，把它们追加到单个文档中，作为未来文章的原始素材。
- **[writing-shape](./writing-shape/SKILL.md)**：拿一个装满原始素材的 markdown 文件，逐段把它塑形成一篇文章，每一步都就格式选择展开争论。
- **[claude-handoff](./claude-handoff/SKILL.md)**：把当前对话交接给一个立即接手工作的全新后台 agent，通过 `claude --bg` 以交接摘要作为种子。用户调用。
- **[setup-ts-deep-modules](./setup-ts-deep-modules/SKILL.md)**：把 dependency-cruiser 接入 TypeScript 仓库，让每个包都成为深模块：实现隐藏在子文件夹中，只能通过入口文件触达，测试也经由这些入口点来检验。用户调用。
- **[implement-spec](./implement-spec/SKILL.md)**：在单个分支上实现整个 spec。把 ticket 当作任务图（而非列表）来处理，在就绪的 frontier 上并行调度实现者 subagent 以获得最大并发，最终以单个 PR 落地。用户调用。
- **[retro](./retro/SKILL.md)**：在一次会话后，就编码 agent 的环境（steering 文件、编码规范、自动化检查、工具链）提出改进建议。STUB：目前只有设计笔记，尚不可用。用户调用。
