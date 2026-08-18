---
name: to-spec
description: 把当前对话整理成一份规格并发布到项目的 issue 跟踪器——不做访谈，只综合你们已经讨论过的内容。
disable-model-invocation: true
commit_version: 6a34259e99bc5fed4f8fe5da61c273dad14edf67
---

本技能利用当前对话上下文和对代码库的理解产出一份规格。**不要**访谈用户——只综合你已经知道的东西。

issue 跟踪器和 triage 标签词汇表应该已经提供给你了。如果没有，告诉用户运行 `/setup-matt-pocock-skills`。

## 流程

1. 探索仓库以了解代码库的现状（如果还没做过）。在整个规格中贯穿使用项目领域术语表的词汇，并尊重你触及区域内的任何 ADR。

2. 勾画出你将在哪些 seam 上测试这个功能。已有 seam 优先于新 seam。使用尽可能高的 seam。如果需要新 seam，在你能达到的最高点提出它们。整个代码库中 seam 越少越好——理想数量是一个。

与用户确认这些 seam 符合他们的预期。

3. 使用下面的模板撰写规格，然后发布到项目的 issue 跟踪器。应用 `ready-for-agent` triage 标签——不需要额外的 triage。

<spec-template>

## Problem Statement

用户面临的问题，从用户的视角描述。

## Solution

问题的解决方案，从用户的视角描述。

## User Stories

一个很长的、编号的用户故事列表。每个用户故事格式为：

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

这个用户故事列表应该极尽详尽，覆盖该功能的方方面面。

## Implementation Decisions

已做出的实现决策列表。可以包括：

- 将构建/修改的模块
- 这些模块将被修改的接口
- 来自开发者的技术澄清
- 架构决策
- Schema 变更
- API 契约
- 具体交互

**不要**包含具体文件路径或代码片段。它们可能很快就会过时。

例外：如果原型产出的代码片段比散文能更精确地编码一个决策（状态机、reducer、schema、类型形状），就把它内联到相关决策中，并简要注明它来自原型。裁剪到富含决策的部分——不是可运行的 demo，只要重要的片段。

## Testing Decisions

已做出的测试决策列表。包括：

- 对什么是好测试的描述（只测试外部行为，不测实现细节）
- 哪些模块将被测试
- 测试的先例（即代码库中类似类型的测试）

## Out of Scope

本规格范围之外事项的说明。

## Further Notes

关于该功能的任何补充说明。

</spec-template>
