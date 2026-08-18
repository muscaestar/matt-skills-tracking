<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 给真正工程师的 Skills（Skills For Real Engineers）

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

我每天用来做真实工程开发——而不是 vibe coding——的 agent 技能。

开发真实应用是难的。GSD、BMAD、Spec-Kit 这类方法试图通过接管流程来帮忙。但这样做的同时，它们拿走了你的控制权，还让流程中的 bug 难以解决。

这些技能被设计成小巧、易于改造、可组合的。它们适用于任何模型。它们基于数十年的工程经验。随意折腾它们。把它们变成你自己的。享受吧。

如果你想跟进这些技能的变化以及我创建的新技能，可以加入我的 newsletter，与约 60,000 名其他开发者一起：

[订阅 Newsletter](https://www.aihero.dev/s/skills-newsletter)

## 安装（30 秒完成）

两条路，两种理念。**[Claude Code 插件](https://code.claude.com/docs/en/plugins)**把整套技能作为一个受管的只读包安装，我发布更新时它随之更新——你是订阅而不是 fork。**[skills.sh](https://skills.sh/mattpocock/skills)** 把可编辑的技能文件复制进你的项目，让你可以折腾它们、把它们变成自己的。二选一——两个都装会让每个技能出现两次。

### 1. 获取技能

<details>
<summary><strong>Claude Code</strong></summary>

```bash
claude plugins install mattpocock-skills
```

或者，在会话内：

```
/plugin install mattpocock-skills
```

它在 Claude Code 的官方 marketplace 里，所以不需要先添加任何东西，更新会自动到达。

</details>

<details>
<summary><strong>Codex 及其他 agent</strong></summary>

```bash
npx skills@latest add mattpocock/skills
```

挑选你想要的技能，以及要安装到哪些编码 agent 上。**安装器允许你选择要安装哪些技能——确保 `setup-matt-pocock-skills` 是其中之一。**

原生 Codex 插件在路线图上——见 [`.agents/adr/0002-ship-as-a-claude-code-plugin.md`](../.agents/adr/0002-ship-as-a-claude-code-plugin.md)（暂未翻译）。

</details>

<details>
<summary><strong>给爱折腾的人</strong></summary>

用同一个安装器，在任何 agent 上——包括 Claude Code：

```bash
npx skills@latest add mattpocock/skills
```

它把技能作为你拥有、可以编辑的普通文件写入你的仓库。没有什么会背着你更新；想要我的最新改动时，用 `npx skills update` 拉取。

</details>

### 2. 运行 `/setup-matt-pocock-skills`

在你的 agent 中运行，每个仓库一次。它会：

- 问你想用哪个 issue 跟踪器（GitHub、Linear 或本地文件）
- 问你 triage ticket 时应用什么标签（`/triage` 使用标签）
- 问你想把我们创建的文档保存在哪里

### 3. 搞定——你可以开工了。

## 这些技能为什么存在

我构建这些技能，是为了修复我在 Claude Code、Codex 和其他编码 agent 身上看到的常见失败模式。

### #1：Agent 做的不是我想要的

> "没有人确切知道自己想要什么"
>
> David Thomas & Andrew Hunt，[The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**。软件开发中最常见的失败模式是错位（misalignment）。你以为开发者知道你想要什么。然后你看到他们做出来的东西——你意识到它根本没理解你。

在 AI 时代也一样。你和 agent 之间有一道沟通鸿沟。修复方法是一场 **grilling 会话**——让 agent 就你要构建的东西向你提出细致的问题。

**修复方法**是使用：

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md)——用于非代码场景
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)——与 [`/grill-me`](./skills/productivity/grill-me/SKILL.md) 相同，但增加了更多好东西（见下文）

这是我最受欢迎的技能。它们帮你在开始之前与 agent 对齐，并深入思考你要做的改动。_每次_想做改动时都用它们。

### #2：Agent 太啰嗦了

> 有了统一语言（ubiquitous language），开发者之间的对话和代码的表达都源自同一个领域模型。
>
> Eric Evans，[Domain-Driven-Design](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**问题**：在项目开始时，开发者和他们为之构建软件的人（领域专家）通常说着不同的语言。

我在我的 agent 身上感受到了同样的张力。Agent 通常被丢进一个项目，被要求边做边摸索行话。于是 1 个词就够的地方它们用 20 个词。

**修复方法**是共享语言。它是一份帮助 agent 解码项目中行话的文档。

<details>
<summary>
示例
</summary>

这是来自我的 `course-video-manager` 仓库的 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 示例。哪个更容易读？

- **之前**："There's a problem when a lesson inside a section of a course is made 'real' (i.e. given a spot in the file system)"
- **之后**："There's a problem with the materialization cascade"

这种简洁在一个又一个会话中持续带来回报。

</details>

这内建于 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)。它是一场 grilling 会话，但同时帮你与 AI 构建共享语言，并把难以解释的决定记录进 ADR。

很难解释这有多强大。它可能是这个仓库里最酷的技术。试试看，眼见为实。

> [!TIP]
> 共享语言除了减少啰嗦还有很多好处：
>
> - **变量、函数和文件被一致地命名**，使用共享语言
> - 其结果是**代码库对 agent 来说更容易导航**
> - Agent 还会**在思考上花更少 token**，因为它能使用更简洁的语言

### #3：代码不能工作

> "永远迈小而有意的步子。反馈速率就是你的速度上限。永远不要承接太大的任务。"
>
> David Thomas & Andrew Hunt，[The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**问题**：假设你和 agent 已经就对齐要构建什么。当 agent _仍然_产出垃圾时会发生什么？

该看看你的反馈回路了。得不到关于它产出的代码实际运行情况的反馈，agent 就是在盲飞。

**修复方法**：你需要惯常的那一组反馈回路：静态类型、浏览器访问和自动化测试。

对于自动化测试，红-绿-重构循环至关重要。agent 先写一个失败的测试，然后修复它。这能给 agent 提供一致水平的反馈，产出好得多的代码。

我构建了一个 **[`/tdd`](./skills/engineering/tdd/SKILL.md) 技能**，可以插进任何项目。它鼓励红-绿-重构，并就什么是好测试、什么是坏测试给 agent 提供充分的指导。

针对调试，我还构建了一个 **[`/diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md) 技能**，把调试最佳实践包装成一个有纪律的循环，逐阶段设闸。

### #4：我们建了一团烂泥

> "_每天_都投入系统的设计。"
>
> Kent Beck，[Extreme Programming Explained](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "最好的模块是深的。它们让大量功能通过一个简单的接口被访问。"
>
> John Ousterhout，[A Philosophy Of Software Design](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**问题**：大多数用 agent 构建的应用都复杂且难以修改。因为 agent 能极大加速编码，它们也加速了软件熵。代码库正以前所未有的速度变得更复杂。

**修复方法**是一种激进的 AI 驱动开发新方式：关心代码的设计。

这内建于这些技能的每一层：

- [`/to-spec`](./skills/engineering/to-spec/SKILL.md) 在创建规格之前，会追问你要动哪些模块

至关重要的是，[`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) 会扫描代码库寻找深化机会，并把候选清单交给你。我建议每隔几天在你的代码库上运行一次。它是勘察，不是救援：在真正老旧的代码库上它会找到真正的候选，但它不会替你解开那团烂泥。

### 总结

软件工程基本功比以往任何时候都重要。这些技能是我把这些基本功凝结为可重复实践的最大努力，帮助你交付职业生涯中最好的应用。享受吧。

## 参考

这些技能沿一条轴划分——谁能调用它们。**用户调用**的技能只有在你主动输入时才可触达（例如 `/grill-me`）；它们的职责是编排。**模型调用**的技能可以由你调用，也可以由 agent 在任务匹配时主动取用；它们承载可复用的纪律。用户调用的技能可以调用模型调用的技能，但永远不能调用另一个用户调用的技能。

### Engineering（工程）

我每天写代码时使用的技能。

**用户调用**

- **[ask-matt](./skills/engineering/ask-matt/SKILL.md)** — 询问哪个技能或流程适合你的处境。它是本仓库中用户调用技能的路由器。
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** — 一场追问式访谈，同时构建项目的领域模型，打磨术语，并实时更新 `CONTEXT.md` 和 ADR。
- **[triage](./skills/engineering/triage/SKILL.md)** — 让 issue 经过一个由分诊角色组成的状态机。
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** — 扫描代码库寻找深化机会，以可视化 HTML 报告呈现，然后就你选中的任何一个继续追问。
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** — 为工程技能配置本仓库（issue 跟踪器、分诊标签、领域文档布局）。在使用其他工程技能之前，每个仓库运行一次。
- **[to-spec](./skills/engineering/to-spec/SKILL.md)** — 把当前对话转化为规格说明，并发布到 issue 跟踪器。不做访谈——只综合你们已经讨论过的内容。
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)** — 把任何计划、规格或对话拆成一组曳光弹 ticket，每个 ticket 都声明其阻塞边——可以是本地文件中的文本，也可以是真实跟踪器上的原生阻塞链接。
- **[implement](./skills/engineering/implement/SKILL.md)** — 构建规格或一组 ticket 所描述的工作，在预先商定的接缝处驱动 `/tdd`，提交前用 `/code-review` 收尾。
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)** — 把一大块工作——多到单个 agent 会话装不下——规划为 issue 跟踪器上一张由决策 ticket 组成的共享地图，一次解决一个，直到通往目的地的路径清晰可见。

**模型调用**

- **[prototype](./skills/engineering/prototype/SKILL.md)** — 构建一个一次性原型来回答设计问题——一个可共享的 HTML 文件用于状态/逻辑问题，或几个可从单一路由切换的截然不同的 UI 变体。
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)** — 针对疑难 bug 和性能回退的严谨诊断循环：建立一条在本 bug 上变红的反馈回路 → 最小化 → 提出假设 → 插桩 → 修复 → 回归测试。
- **[research](./skills/engineering/research/SKILL.md)** — 对照高可信度的一手来源调查一个问题，并以带引用的 Markdown 文件形式把发现留在仓库中；作为后台 agent 运行。
- **[tdd](./skills/engineering/tdd/SKILL.md)** — 红-绿-重构循环的测试驱动开发。一次一个垂直切片地构建功能或修复 bug。
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)** — 积极构建和打磨项目的领域模型——对照术语表挑战术语、用边角案例场景做压力测试、实时更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)** — 设计深模块的共享纪律和词汇：小接口背后的大量行为，落在干净的接缝上，通过该接口可测试。
- **[code-review](./skills/engineering/code-review/SKILL.md)** — 对自固定点以来的 diff 做双轴审查：**Standards**（是否遵循仓库的编码标准，外加 Fowler 坏味道基线？）和 **Spec**（是否忠实实现来源 issue/规格？），以并行子 agent 运行，互不污染。
- **[resolving-merge-conflicts](./skills/engineering/resolving-merge-conflicts/SKILL.md)** — 逐块处理进行中的 git merge 或 rebase 冲突，按追溯到双方一手来源的意图来解决，然后完成操作——绝不 `--abort`。
- **[wizard](./skills/engineering/wizard/SKILL.md)** — 生成一个交互式 bash 向导，引导人类完成只有他们能做的步骤：配置基础设施、设置凭据或 CI 密钥、在陌生的第三方仪表盘中操作，或执行一次性迁移或切换。

### Productivity（生产力）

通用工作流工具，不特定于代码。

**用户调用**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)** — 就一份计划或设计被穷追不舍地访谈，直到设计树的每个分支都有结论。
- **[handoff](./skills/productivity/handoff/SKILL.md)** — 把当前对话压缩成交接文档，让另一个 agent 能继续这项工作。
- **[teach](./skills/productivity/teach/SKILL.md)** — 跨多个会话教用户一项新技能或概念，以当前目录作为有状态的教学工作区。
- **[to-questionnaire](./skills/productivity/to-questionnaire/SKILL.md)** — 把你一个人无法回答的决定变成一份 Markdown 问卷，发给那个能回答的人——异步填写，或在会议上一起填。它追问的是你这次发送（发给谁、你需要什么回来），而不是主题本身。
- **[wait-what](./skills/productivity/wait-what/SKILL.md)** — 在一条消息没听懂的那一刻触发它。Agent 会用你缺的上下文、用大白话、用你的 `CONTEXT.md` 词汇重新讲一遍。

**模型调用**

- **[grilling](./skills/productivity/grilling/SKILL.md)** — 就一份计划、一个决定或一个想法穷追不舍地访谈用户，直到设计树的每个分支都有结论。它是 `grill-me`、`grill-with-docs`、`triage`、`wayfinder` 和 `improve-codebase-architecture` 背后可复用的访谈原语。
- **[writing-for-agents](./skills/productivity/writing-for-agents/SKILL.md)** — 为 agent 写文档：技能、AGENTS.md/CLAUDE.md，以及任何 agent 经由指针触达的文档。
