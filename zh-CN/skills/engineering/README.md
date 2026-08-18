# Engineering（工程）

我每天写代码时都会用到的技能。

## 用户调用

仅当你主动输入时可触发（Claude Code：`disable-model-invocation: true`；Codex：`agents/openai.yaml` 中的 `policy.allow_implicit_invocation: false`）。

- **[ask-matt](./ask-matt/SKILL.md)** — 询问哪个技能或流程适合你的处境。它是本仓库中用户调用技能的路由器。
- **[grill-with-docs](./grill-with-docs/SKILL.md)** — 一场追问式访谈，同时构建项目的领域模型，打磨术语，并实时更新 `CONTEXT.md` 和 ADR。
- **[triage](./triage/SKILL.md)** — 让 issue 经过一个由分诊角色组成的状态机。
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)** — 扫描代码库寻找深化机会，以可视化 HTML 报告呈现，然后就你选中的任何一个继续追问。
- **[setup-matt-pocock-skills](./setup-matt-pocock-skills/SKILL.md)** — 为工程技能配置本仓库（issue 跟踪器、分诊标签、领域文档布局）。每个仓库运行一次。
- **[to-spec](./to-spec/SKILL.md)** — 把当前对话转化为规格说明，并发布到 issue 跟踪器。
- **[to-tickets](./to-tickets/SKILL.md)** — 把任何计划、规格或对话拆成一组曳光弹 ticket，每个 ticket 都声明其阻塞边——可以是本地文件中的文本，也可以是真实跟踪器上的原生阻塞链接。
- **[implement](./implement/SKILL.md)** — 构建规格或一组 ticket 所描述的工作，在预先商定的接缝处驱动 `/tdd`，提交前用 `/code-review` 收尾。
- **[wayfinder](./wayfinder/SKILL.md)** — 把一大块工作——多到单个 agent 会话装不下——规划为 issue 跟踪器上一张由决策 ticket 组成的共享地图，一次解决一个，直到通往目的地的路径清晰可见。

## 模型调用

模型或用户都可触发（提供丰富的触发措辞，让模型也会主动使用它们）。

- **[prototype](./prototype/SKILL.md)** — 构建一个一次性原型来回答设计问题：一个可共享的 HTML 文件用于状态/逻辑，或几个可切换的 UI 变体。
- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)** — 针对疑难 bug 和性能回退的严谨诊断循环：建立一条在本 bug 上变红的反馈回路 → 最小化 → 提出假设 → 插桩 → 修复 → 回归测试。
- **[research](./research/SKILL.md)** — 对照高可信度的一手来源调查一个问题，并以带引用的 Markdown 文件形式把发现留在仓库中；作为后台 agent 运行。
- **[tdd](./tdd/SKILL.md)** — 红-绿-重构循环的测试驱动开发。一次一个垂直切片地构建功能或修复 bug。
- **[domain-modeling](./domain-modeling/SKILL.md)** — 积极构建和打磨项目的领域模型——挑战术语、用场景做压力测试、实时更新 `CONTEXT.md` 和 ADR。
- **[codebase-design](./codebase-design/SKILL.md)** — 设计深模块的共享纪律和词汇：小接口、干净的接缝、通过接口可测试。
- **[code-review](./code-review/SKILL.md)** — 对自固定点以来的 diff 做双轴审查：**Standards**（是否遵循仓库的编码标准，外加 Fowler 坏味道基线？）和 **Spec**（是否忠实实现来源 issue/规格？），以并行子 agent 运行。
- **[resolving-merge-conflicts](./resolving-merge-conflicts/SKILL.md)** — 逐块处理进行中的 git merge 或 rebase 冲突，按追溯到双方一手来源的意图来解决，然后完成操作——绝不 `--abort`。
- **[wizard](./wizard/SKILL.md)** — 生成一个交互式 bash 向导，引导人类完成只有他们能做的步骤：配置基础设施、设置凭据或 CI 密钥、在陌生的第三方仪表盘中操作，或执行一次性迁移或切换。
