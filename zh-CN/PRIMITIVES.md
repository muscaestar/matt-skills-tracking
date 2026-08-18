# 原语清单（Primitives / Leading Words）

这套技能包的词汇是**跨文件共享**的：一个词在一个技能里定义、被其他技能引用。`writing-for-agents` 把这类词称为 **leading word（主导词）**——agent 借助它思考，引用方借助它连回定义源头。翻译时英文 token 一旦丢失，引用就断了（规范见 `.github/copilot-instructions.md` 翻译规范第 3 条）。

**本文档是全项目原语的登记处。** 用途：

1. 翻译新文件 / 同步上游改动前，先查这份表，跟随既有 token，不另造译名。
2. 上游引入新原语时，先在这里登记（英文 token + 中文 token + 定义源头），再翻译。
3. 发现引用方与定义源头 token 不一致时，以定义源头为准，同步其余文件。

## Token 策略图例

- **【英文贯通】** 被其他文件以英文裸引用的词：定义处写作「**English（中文）**」，之后正文统一用英文 token。
- **【中文贯通】** 无英文裸引用的词：定义处写作「**中文（English）**」，之后正文统一用中文 token。
- 无论哪种，**同一原语全项目只有一个 token**。

## 跨技能共享原语速查表

这些原语被多个技能引用，token 一致性最关键：

| 原语 | 中文 token | 策略 | 定义源头 | 主要引用方 |
|---|---|---|---|---|
| `frontier` | 前沿 | 【英文贯通】 | grilling | wayfinder、to-tickets、ask-matt |
| `seam` | 接缝 | 【英文贯通】 | codebase-design | tdd、diagnosing-bugs、to-spec、improve-codebase-architecture、implement、setup-ts-deep-modules |
| `adapter` | 适配器 | 【英文贯通】 | codebase-design | DEEPENING.md、setup-ts-deep-modules |
| `deep module` / `shallow module` | 深模块 / 浅模块 | 【中文贯通】 | codebase-design | improve-codebase-architecture、setup-ts-deep-modules、DEEPENING.md |
| `leverage` / `locality` / `depth` | 杠杆 / 局部性 / 深度 | 【中文贯通】 | codebase-design | improve-codebase-architecture、DESIGN-IT-TWICE.md |
| `the deletion test` | 删除测试 | 【英文贯通】 | codebase-design | improve-codebase-architecture |
| `the interface is the test surface` | 接口就是测试面 | 【英文贯通】 | codebase-design | improve-codebase-architecture、DEEPENING.md |
| `hypothetical seam` / `real seam` | 假设性 / 真实 seam | 【英文贯通】 | codebase-design | improve-codebase-architecture、DEEPENING.md |
| `internal seams` / `external seam` | 内部 / 外部 seam | 【英文贯通】 | codebase-design | DEEPENING.md |
| `tracer bullet` | 曳光弹 | 【中文贯通】 | to-tickets | tdd、ask-matt |
| `tight` / `red`（goes red、`red-capable`） | 紧凑 / 变红（能变红） | 【中文贯通】 | diagnosing-bugs | ask-matt |
| `HITL` / `AFK` | 人类在环 / agent 单驱 | 【英文贯通】 | wayfinder | （ticket 类型标注，跟踪器上直接使用） |
| `explore` / `exploit` | 探索 / 利用 | 【英文贯通】 | writing-fragments（explore）、writing-shape（exploit） | writing-beats、三者互引 |
| `grounded`（grounding） | 已落地（落地） | 【中文贯通】 | writing-shape | writing-beats |
| `leading word` | 主导词 | 【中文贯通】 | writing-for-agents | writing-fragments、本文档 |
| `context pointer` | 上下文指针 | 【中文贯通】 | writing-for-agents | prototype、wayfinder、setup-ts-deep-modules、diagnosing-bugs |
| `primary source` | 一手来源 | 【中文贯通】 | research、prototype、resolving-merge-conflicts（各自定义，同源概念） | ask-matt |
| `glossary` | 术语表 | 【中文贯通】 | domain-modeling | triage、to-spec、to-tickets、setup-matt-pocock-skills、wait-what |
| `design tree` / `rounds` | 设计树 / 轮次 | 【中文贯通】 | grilling | ask-matt、triage、loop-me |
| `ready-for-agent` 等五个状态标签 | 不译 | 【英文贯通】 | triage | to-spec、to-tickets、setup-matt-pocock-skills、code-review |

---

## 按技能的完整原语登记

按依赖分层组织（层间关系见 `ask-matt` 的路由图）。

### 词汇原语层

#### grilling（面试原语）— `skills/productivity/grilling/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `design tree` | 设计树 | 每个决策分支出挂在其下的更多决策，追问就是遍历这棵树 |
| `rounds` | 轮次 | 按轮处理设计树，一轮问完整个 frontier |
| `frontier` | 前沿【英文贯通】 | 前置条件已确定、现在就能提问的决策集合 |
| facts vs decisions | 事实归 agent，决策归用户 | 事实由 agent 派子 agent 去查，决策永远交给用户 |

#### domain-modeling（领域语言）— `skills/engineering/domain-modeling/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `domain model` | 领域模型 | 项目的领域概念体系 |
| `glossary` | 术语表 | `CONTEXT.md` 的唯一角色："它是术语表，仅此而已" |
| `ADR` | 不译 | 架构决策记录；三标准：难以逆转（hard to reverse）、没有上下文会很意外、真实权衡的结果 |
| `active discipline` | 主动纪律 | 主动改变模型（挑战术语、写 ADR），区别于只读 `CONTEXT.md` 的一行式习惯 |

#### codebase-design（深模块词汇）— `skills/engineering/codebase-design/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `Module` | 模块 | 任何有 interface 和 implementation 的东西，刻意与规模无关 |
| `Interface` | 接口 | 调用方正确使用模块必须知道的一切（不止类型签名） |
| `Implementation` | 实现 | 模块内部的代码主体 |
| `Depth` | 深度 | interface 处的杠杆：每单位接口能行使多少行为 |
| `Seam` | 接缝【英文贯通】 | 无需就地编辑就能改变行为的位置（Michael Feathers） |
| `Adapter` | 适配器【英文贯通】 | 在 seam 处满足 interface 的具体事物，描述角色而非实质 |
| `Leverage` | 杠杆 | depth 给调用方的回报：一次实现，N 个调用点受益 |
| `Locality` | 局部性 | depth 给维护者的回报：变更、bug、知识集中一处 |
| `deep module` / `shallow module` | 深模块 / 浅模块 | 小接口+大量实现 / 大接口+薄薄实现 |
| `the deletion test` | 删除测试【英文贯通】 | 想象删除模块：复杂度消失=透传；在 N 个调用方重现=自食其力 |
| `the interface is the test surface` | 接口就是测试面【英文贯通】 | 调用方和测试跨越同一条 seam |
| `hypothetical seam` / `real seam` | 假设性 / 真实 seam【英文贯通】 | 一个 adapter = 假设性 seam，两个 = 真实 seam |
| `internal seams` / `external seam` | 内部 / 外部 seam【英文贯通】 | 实现私有、供自测的 seam / 位于 interface 处的 seam |
| `port` | 端口 | 跨网络边界的 seam 处定义的接口（DEEPENING.md） |
| 依赖四类别 | 进程内 / 本地可替换 / 远程但自有 / 真正外部 | 决定深化后如何跨 seam 测试（DEEPENING.md） |
| `design-it-twice` | 不译 | 并行子 agent 用多种截然不同的方式设计接口再比较（DESIGN-IT-TWICE.md） |

### 主流程（idea → ship）

#### to-spec — `skills/engineering/to-spec/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `spec` | 规格 | 从对话上下文综合出的规格说明，发布到 issue 跟踪器 |
| seam 选择 | （引用 codebase-design） | 优先既有 seam、用最高的 seam、理想数量是一 |

#### to-tickets — `skills/engineering/to-tickets/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `tracer bullet` | 曳光弹 | 窄而完整的垂直切片 ticket，每层都切到、可独立演示 |
| `vertical slice` / `horizontal slicing` | 垂直切片 / 水平切片 | 垂直=穿透所有层；水平=按层切（反模式） |
| `blocking edges` | 阻塞边 | ticket 声明的"被哪些 ticket 卡住" |
| `wide refactor` | 宽幅重构 | 垂直切片的例外：一次机械改动炸遍全库，无法垂直切 |
| `blast radius` | 爆炸半径 | 一次编辑破坏的调用点范围，决定迁移批次大小 |
| `expand–contract` | 扩张–收缩 | 宽幅重构的排序法：先并存扩张、分批迁移、最后收缩删除 |

#### tdd — `skills/engineering/tdd/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `red → green` | 不译 | 先写失败测试，再写刚好通过的代码 |
| 反模式 `Implementation-coupled` | 与实现耦合 | 测试随重构而坏、行为却没变 |
| 反模式 `Tautological` | 同义反复 | 断言用与代码相同的方式重算期望值，天然通过 |
| 反模式 `Horizontal slicing` | 水平切片 | 先写所有测试再写所有实现，测的是想象中的行为 |

#### code-review — `skills/engineering/code-review/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| 两轴 `Standards` / `Spec` | 不译 | 标准轴（是否遵循成文标准）+ 规格轴（是否实现来源 issue），并行子 agent 分跑、并排报告 |
| `fixed point` | 固定点 | 用户提供的对照点（commit/branch/tag/merge-base） |
| `smell baseline` | 嗅觉基线 | 12 个 Fowler 坏味道：Mysterious Name、Duplicated Code、Feature Envy、Data Clumps、Primitive Obsession、Repeated Switches、Shotgun Surgery、Divergent Change、Speculative Generality、Message Chains、Middle Man、Refused Bequest（永远 labeled heuristic，仓库成文标准优先） |

### On-ramps 与健康维护

#### triage — `skills/engineering/triage/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| 类别角色 `bug` / `enhancement` | 不译 | issue 的两个类别角色 |
| 状态角色 `needs-triage` / `needs-info` / `ready-for-agent` / `ready-for-human` / `wontfix` | 不译 | 五状态状态机；每个 issue 恰好一个类别角色 + 一个状态角色 |
| `agent brief` | agent 简报 | `ready-for-agent` 时发布的耐久简报（AGENT-BRIEF.md） |
| `.out-of-scope/` | 不译 | 被拒绝请求的知识库（OUT-OF-SCOPE.md） |
| `triage notes` | triage 笔记 | `needs-info` 时发布的进展记录，避免重复提问 |

#### diagnosing-bugs — `skills/engineering/diagnosing-bugs/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `tight`（feedback loop） | 紧凑（的反馈回路） | 快速、确定性、信号尖锐、agent 可运行的通过/失败信号 |
| `red` / `red-capable` | 变红 / 能变红 | 能在这个 bug 上变红、修复后变绿；断言用户描述的确切症状 |
| 正确的 seam | （引用 codebase-design） | 能按真实发生方式走真实 bug 模式的 seam；没有正确 seam 本身就是发现 → 转交 improve-codebase-architecture |

#### wayfinder — `skills/engineering/wayfinder/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `destination` | 目的地 | 这张地图要找到路前往的终点，命名它是绘制地图的第一个动作 |
| `shared map` / the map | 共享地图 | issue 跟踪器上的 `wayfinder:map` issue，索引而非存储 |
| `decision tickets` | 决策 ticket | 解决结果是"一个决定"而非构建切片的子 issue |
| `fog of war` | 战争迷雾 | 看得见要来但还无法精确表述的决策/调查，写进 Not yet specified |
| `claim` | 认领 | 把 ticket 指派给自己即认领，先于一切工作 |
| `HITL` / `AFK` | 【英文贯通】 | 人类在环 / agent 单独驱动 |
| ticket 四类型 | research / prototype / grilling / task | 不译；task 是唯一"动手做"的类型，靠解锁决策赢得位置 |
| 地图小节 | `Decisions so far` / `Not yet specified` / `Out of scope` | 不译（issue 模板内的字面小节名） |
| decisions, not deliverables | 产决策，不产交付物 | 地图完成=路已清晰，构建移交主流程的 to-spec |

#### improve-codebase-architecture — `skills/engineering/improve-codebase-architecture/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `deepening opportunities` | 深化机会 | 把浅模块变成深模块的重构候选，HTML 报告呈现 |
| ADR 冲突标注 | ADR 冲突 | 候选与既有 ADR 矛盾时明确标出，而非回避 |

### 阶段边界与路由（ask-matt）— `skills/engineering/ask-matt/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `flow` / `main flow` / `on-ramp` | 流程 / 主流程 / 匝道 | 穿过技能的路径 / 想法→交付的主路 / 产生工作后并入主路的起始情形 |
| `phase` / `phase boundary` | 阶段 / 阶段边界 | 会话内的一块工作；边界处五个选项：Continue、/clear、/handoff、subagent、/compact（默认 /compact，PHASE-BOUNDARIES.md） |
| `smart zone` | 智能区 | 模型仍能清晰推理的上下文窗口（约 150k token） |

### 独立技能

#### prototype — `skills/engineering/prototype/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `throwaway` | 一次性 | 用来回答一个问题的一次性代码；一次性是写法约束，不是销毁承诺 |
| 两分支 logic / UI | 逻辑 / UI | "状态模型顺手吗"→单文件 HTML；"应该长什么样"→多变体路由 |
| `primary source` 捕获 | 一手来源 | 原型提交到 main 之外的 `prototype/<name>` 分支，从实现 issue 指过去 |

#### research — `skills/engineering/research/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `primary sources` | 第一手来源 | 官方文档、源代码、规范、第一方 API；每条论断追溯到拥有它的源头 |
| `background agent` | 后台 agent | 研究委托给后台 agent，主会话继续工作 |

#### handoff / claude-handoff — `skills/productivity/handoff/`、`skills/in-progress/claude-handoff/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `handoff` | 交接 | 把对话压缩成交接文档；窄用途：新 harness、新目录、同事、阶段中分叉 |
| `suggested skills` | 建议技能 | 交接文档中点名下一个 agent 应调用的技能 |

#### wizard — `skills/engineering/wizard/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `wizard` | 向导 | 引导人类完成只有人能做的步骤的交互式 bash 脚本 |
| `stage` | 阶段 | 一个阶段一件聚焦的事；`STAGES` 标记以上的库永不手改 |

#### wait-what — `skills/productivity/wait-what/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `ubiquitous language` | 通用语言 | 用 `CONTEXT.md` 的领域词汇重新讲一遍（引用 domain-modeling 的产物） |

#### teach — `skills/productivity/teach/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `mission` | 任务 | `MISSION.md`，学习兴趣的原因，一切教学的地基 |
| `lesson` | 课程 | 一节课=一个自包含 HTML，教一件紧扣任务的小事 |
| `learning records` | 学习记录 | 教学版的 ADR，用于计算最近发展区 |
| `zone of proximal development` | 最近发展区 | 挑战"刚刚好"的区域 |
| `fluency strength` / `storage strength` | 流畅强度 / 存储强度 | 当下提取能力（会骗人）/ 长期保持能力（真目标） |
| `desirable difficulty` | 合意困难 | 用提取练习、间隔、交错制造存储强度 |
| knowledge / skills / wisdom | 知识 / 技能 / 智慧 | 来自资源 / 来自课程 / 来自社区实战 |

#### to-questionnaire — `skills/productivity/to-questionnaire/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `questionnaire` | 问卷 | 把"别人脑子里的答案"引导出来的 Markdown 文档 |
| grill the send, not the subject | 追问发送，不问主题 | 只问用户答得上来的：发给谁、要回什么 |
| `the gap` | 差距 | 接收方所知与用户所需之间的差，问卷瞄准它 |

#### resolving-merge-conflicts — `skills/engineering/resolving-merge-conflicts/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| resolve by intent | 按意图解决 | 逐 hunk 追溯到各方的一手来源（commit、PR、issue）按意图解决，绝不 `--abort` |

### 元层：写给 agent 的文档

#### writing-for-agents — `skills/productivity/writing-for-agents/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `leading word` | 主导词 | 已存在于模型预训练中的紧凑概念，作为 token 重复以锚定行为——**本文档登记的就是各技能的主导词** |
| `context pointer` | 上下文指针 | 指明上下文外材料并编码触达条件的引用；措辞决定触发可靠性 |
| `context load` / `cognitive load` | 上下文负载 / 认知负载 | 常驻材料对 agent 窗口的成本 / 文档体系对人类的成本 |
| 信息层级 | in-file step / in-file reference / disclosed reference | 步骤与参考在文档内的三级摆放 |
| `progressive disclosure` | 渐进披露 | 把只有部分分支需要的材料推到指针后面 |
| `co-location` / `sprawl` | 同置 / 蔓延 | 概念的定义、规则、警告放一处 / 文档过长的失败模式 |
| `completion criterion` | 完成标准 | 每步收尾的"完成"条件；要清晰（防过早完成）、有要求（驱动 legwork） |
| `sediment` / `no-op` / `cache` | 沉积 / 无操作 / 缓存 | 只增不改堆积的死层 / 模型默认就遵守的废话指令 / 转述环境的文档 |

### in-progress 区

#### loop-me — `skills/in-progress/loop-me/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `loop` | 循环 | 用户生活中反复出现的模式，值得委托的对象 |
| `workflow` | 工作流 | 一个循环的规格，落在 `workflows/*.md` |
| `trigger` | 触发器 | 事件或计划；事件触发通常更高效 |
| `checkpoint` | 检查点 | 人类在环的验证/决策点 |
| `push right` | 右推 | 把检查点尽量推迟，人类只被问一次、在最晚、万事俱备时 |
| `brief` | 简报 | 检查点呈现的决策就绪摘要，不是原始输出 |

#### writing-fragments / writing-shape / writing-beats — `skills/in-progress/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `explore` / `exploit` | 【英文贯通】 | fragments=拓宽空间不锁定结构；shape/beats=锁定结构开采素材堆 |
| `fragment` | 碎片 | 可能留存到终稿的文本片段，作者可读即可；最有价值的是主导词 |
| `the pile` | 素材堆 | exploit 阶段的只读输入 |
| `grounded` / grounding | 已落地 / 落地 | 概念要么读者进场就会（prerequisite 先备概念），要么由前文章节落地，之后的块才能倚赖 |
| `beat` | 节拍 | 文章旅程的一步移动，做一件事就停（writing-beats） |

#### setup-ts-deep-modules — `skills/in-progress/setup-ts-deep-modules/`

| 原语 | 中文 token | 定义 |
|---|---|---|
| `entry points` | 入口点 | 包根目录的文件=公开表面；任何子文件夹一律私有 |
| `barrel file` | barrel 文件 | re-export 整个子树的 index，明确不鼓励；用多个小入口点替代 |

---

## 登记规则

1. 新原语 = 上游某技能**定义**了一个被（或可能被）其他文件引用的词。普通术语不登记。
2. 登记时确定：英文 token、中文 token、策略（英文贯通/中文贯通）、定义源头文件。
3. 策略判断：已有文件以英文裸引用该词 → 【英文贯通】；否则 → 【中文贯通】。
4. 翻译时发现表中没有的原语：先登记，再翻译。
5. 上游改名/删除原语：先改本表，再同步所有引用文件。
