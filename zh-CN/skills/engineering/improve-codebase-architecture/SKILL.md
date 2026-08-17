---
name: improve-codebase-architecture
description: 扫描代码库寻找深化机会，以可视化 HTML 报告呈现，然后就你选中的任何一个继续追问。
disable-model-invocation: true
commit_version: fcf0071560d32913c9d4f820e0d7ca467c881619
---

# Improve Codebase Architecture

找出架构摩擦，提出**深化机会（deepening opportunities）**——把浅模块变成深模块的重构。目标是可测试性和 AI 可导航性。

本命令以项目领域模型为*依据*，并建立在一套共享设计词汇之上：

- 调用 Skill 工具，使用 "codebase-design" 获取架构词汇（**module**、**interface**、**depth**、**seam**、**adapter**、**leverage**、**locality**）及其原则（删除测试、“接口就是测试面”、“一个 adapter = 假设性接缝，两个 = 真实接缝”）。每条建议都要严格使用这些术语——不要漂移到 “component”、“service”、“API” 或 “boundary”。
- `CONTEXT.md` 中的领域语言为好接缝命名；`docs/adr/` 中的 ADR 记录本命令不应重新争辩的决策。

## 流程

### 1. 探索

**先定范围再扫描——YAGNI。** 深化一个模块的回报是让它未来的修改更容易，所以要格外重视代码库中最近变更过的部分。在开始看之前，先决定*看哪里*：

- 如果用户指明了方向——一个模块、子系统或痛点——就采用它，跳过下面的推断。
- 否则，往回走一段可观的提交历史（`git log --oneline`），找出代码库的热点——反复出现的文件和区域——让这些路径优先吸引你的注意力。如果改动分散、没有明显热点，就扩大范围。

先阅读项目的领域术语表（`CONTEXT.md`）和所接触区域的任何 ADR。

然后派一个子 agent 遍历代码库。不要套用僵硬的启发式规则——有机地探索，并记下你在哪里感到摩擦：

- 理解一个概念时，哪里需要在许多小模块之间来回跳？
- 哪些模块是**浅**的——接口几乎和实现一样复杂？
- 哪里为了可测试性抽出了纯函数，但真正的 bug 却藏在它们被调用的方式里（没有**局部性**）？
- 哪些紧耦合模块在自己的接缝处发生泄漏？
- 代码库的哪些部分没有测试，或难以通过当前接口测试？

对任何你怀疑是浅模块的东西应用**删除测试**：删除它会集中复杂度，还是仅仅转移复杂度？“会集中”正是你要找的信号。

### 2. 以 HTML 报告呈现候选

把一份自包含的 HTML 文件写到操作系统临时目录，以免任何东西落入仓库。从 `$TMPDIR` 解析临时目录，回退到 `/tmp`（Windows 上为 `%TEMP%`），写入 `<tmpdir>/architecture-review-<timestamp>.html`，让每次运行都得到新文件。为用户打开它——Linux 用 `xdg-open <path>`，macOS 用 `open <path>`，Windows 用 `start <path>`——并告诉他们绝对路径。

报告用 **CDN 版 Tailwind** 做布局和样式，在图形/流程/序列图能可靠表达结构的地方用 **CDN 版 Mermaid** 画图。把 Mermaid 与手工 CSS/SVG 视觉混用——关系呈图形结构（调用图、依赖、序列）时用 Mermaid；想要更有编辑感（体量图、剖面图、折叠动画）时用手工 div/SVG。每个候选都要有**改前/改后可视化**。要视觉化。

为每个候选渲染一张卡片，包含：

- **Files**——涉及哪些文件/模块
- **Problem**——为什么当前架构会造成摩擦
- **Solution**——用平实语言描述会发生什么变化
- **Benefits**——用局部性和杠杆解释，以及测试会如何改善
- **Before / After diagram**——并排、手工绘制，展示“浅”与“深化”
- **Recommendation strength**——`Strong`、`Worth exploring`、`Speculative` 之一，渲染成徽章

报告以**Top recommendation** 栏目结束：你会先处理哪个候选，以及为什么。

**领域用语使用 CONTEXT.md 词汇，架构用语使用 `/codebase-design` 词汇。** 如果 `CONTEXT.md` 定义了 “Order”，就说 “the Order intake module”——而不是 “the FooBarHandler”，也不是 “the Order service”。

**ADR 冲突**：如果某个候选与现有 ADR 矛盾，只有当摩擦真实到值得重新讨论该 ADR 时才呈现。在卡片中清晰标记（例如警告提示：_“与 ADR-0007 冲突——但值得重新讨论，因为……”_）。不要列出 ADR 所禁止的每一个理论性重构。

完整 HTML 脚手架、图示模式与样式指南见 [HTML-REPORT.md](HTML-REPORT.md)。

先**不要**提出接口。文件写完后，问用户：“Which of these would you like to explore?”

### 3. 追问循环

用户选定候选后，调用 Skill 工具，使用 "grilling" 与他们一起走决策树——约束、依赖、深化后模块的形状、接缝后面放什么、哪些测试能存活。

决策成形时副作用即时发生——调用 Skill 工具，使用 "domain-modeling" 让领域模型随时保持最新：

- **给深化后的模块起了一个 `CONTEXT.md` 中没有的概念名？** 把这个术语加进 `CONTEXT.md`。文件不存在就按需创建。
- **对话中打磨了模糊术语？** 当场更新 `CONTEXT.md`。
- **用户以有承重作用的理由拒绝了候选？** 提议写 ADR，措辞如：_“想让我把这个记录为 ADR，让未来的架构审查不再重复建议吗？”_ 只有当未来探索者确实需要这个理由来避免重复建议时才提议——临时理由（“现在不值得”）和显而易见的不算。
- **想为深化后的模块探索替代接口？** 调用 Skill 工具，使用 "codebase-design" 及其 design-it-twice 并行子 agent 模式。
