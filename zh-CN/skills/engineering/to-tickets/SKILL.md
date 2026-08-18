---
name: to-tickets
description: 把计划、规格或当前对话拆成一组曳光弹（tracer-bullet）ticket，每个 ticket 声明自己的阻塞边，发布到配置好的跟踪器——本地时每 ticket 一个文件、边以文本表示，真实跟踪器上则使用原生阻塞链接。
disable-model-invocation: true
commit_version: 6a34259e99bc5fed4f8fe5da61c273dad14edf67
---

# To Tickets

把计划、规格或对话拆成一组 **ticket**——曳光弹式的垂直切片，每个都声明**阻塞**它的其他 ticket。

issue 跟踪器和 triage 标签词汇表应该已经提供给你了。如果没有，告诉用户运行 `/setup-matt-pocock-skills`。

## 流程

### 1. 收集上下文

利用对话上下文中已有的内容。如果用户传入了引用（规格路径、issue 编号或 URL）作为参数，获取它并阅读其完整正文和评论。

### 2. 探索代码库（可选）

如果还没有探索过代码库，先探索以了解代码现状。ticket 标题和描述应使用项目领域术语表的词汇，并尊重你触及区域内的 ADR。

寻找对代码做预重构（prefactor）的机会，让实现更容易。"Make the change easy, then make the easy change."（先让改动变容易，再做那个容易的改动。）

### 3. 起草垂直切片

把工作拆成**曳光弹（tracer bullet）**ticket。

<vertical-slice-rules>

- 每个切片切出一条穿过每一层（schema、API、UI、测试）的窄但**完整**的路径——是垂直的，**不是**某一层的水平切片
- 一个完成的切片可以独立演示或验证
- 每个切片的大小以能装进一个全新的上下文窗口为准
- 任何预重构都应该先做

</vertical-slice-rules>

给每个 ticket 标出它的**阻塞边**——必须先完成它才能开始的其他 ticket。没有阻塞方的 ticket 可以立即开始。

**宽幅重构（wide refactor）是垂直切片的例外。** **宽幅重构**是一种机械性改动——重命名一列、改一个共享符号的类型——其**爆炸半径（blast radius）**扇形扩散到整个代码库，于是一次编辑就会同时破坏上千个调用点，任何垂直切片都无法以绿色落地。不要硬把它塞进曳光弹；按 **expand–contract（扩张–收缩）**来排序。先扩张：在旧形式旁边添加新形式，什么都不破坏。然后按爆炸半径划定批次迁移调用点（按包、按目录），每个批次一个 ticket、被扩张 ticket 阻塞，批与批之间保持 CI 绿色，因为旧形式仍然存在。最后收缩：当不再有任何调用者时删除旧形式，这个 ticket 被每个迁移批次阻塞。当连批次都无法单独保持绿色时，保留这个顺序，但让它们共享一个集成分支，共同阻塞一个最终的"集成并验证"ticket——绿色只在那里承诺。

### 4. 向用户提问确认

把提议的拆分以编号列表呈现。对每个 ticket，展示：

- **标题**：简短的描述性名称
- **Blocked by**：哪些其他 ticket（如果有）必须先完成
- **交付什么**：这个 ticket 打通的端到端行为

问用户：

- 粒度感觉合适吗？（太粗 / 太细）
- 阻塞边正确吗——每个 ticket 是否只依赖真正卡住它的 ticket？
- 有没有 ticket 应该合并或进一步拆分？

迭代直到用户认可这个拆分。

### 5. 把 ticket 发布到配置好的跟踪器

发布认可的 ticket。**怎么发**取决于 `/setup-matt-pocock-skills` 配置的跟踪器——ticket 本身不变，只有阻塞边的形态变化：

- **本地文件** → 在 `.scratch/<feature-slug>/issues/<NN>-<slug>.md` 下每个 ticket 写一个文件，按依赖顺序（阻塞方在前）从 `01` 开始编号。每个文件的 "Blocked by" 列出它依赖的编号/标题。使用下面的单 ticket 文件模板——每个文件一个 ticket，永远不要合并成单个文件。
- **真实 issue 跟踪器（GitHub、Linear 等）** → 按依赖顺序（阻塞方在前）每个 ticket 发布一个 issue，让每个 ticket 的阻塞边能引用真实标识符。平台有原生阻塞 / 子 issue 关系就用原生的；否则把每个 ticket 的 "Blocked by" 设为阻塞它的 issue。除非另有指示，应用 `ready-for-agent` triage 标签——这些 ticket 按构造就是 agent 可以直接认领的。

从 **frontier** 开始工作：阻塞方全部完成的任何 ticket。对于纯线性链条，那就是从上到下。

**不要**关闭或修改任何父 issue。

<local-ticket-template>

# <NN> — <Ticket 标题>

**What to build:** 这个 ticket 打通的端到端行为，从用户的视角描述——不是逐层的实现清单。

**Blocked by:** 卡住这个 ticket 的编号/标题，或 "None — can start immediately"。

**Status:** ready-for-agent

- [ ] 验收标准 1
- [ ] 验收标准 2

</local-ticket-template>

<issue-template>

## Parent

对跟踪器上父 issue 的引用（如果来源是一个已有 issue，否则省略本节）。

## What to build

这个 ticket 打通的端到端行为，从用户的视角描述——不是逐层实现。

## Acceptance criteria

- [ ] 标准 1
- [ ] 标准 2

## Blocked by

- 对每个阻塞 ticket 的引用，或 "None — can start immediately"。

</issue-template>

两种形式下都避免具体文件路径或代码片段——它们很快就会过时。例外：如果原型产出的代码片段比散文能更精确地编码一个决策（状态机、reducer、schema、类型形状），就把它内联进来，并简要注明它来自原型。裁剪到富含决策的部分——不是可运行的 demo，只要重要的片段。
