# zh-CN 中文翻译目录

本目录用于存放 [mattpocock/skills](https://github.com/mattpocock/skills) 的中文翻译内容。

## 目录结构约定

本目录的结构 **与仓库根目录的英文原始结构保持一一对应**，方便对照和后续维护：

```
zh-CN/
├── README.md                  # 本文件
├── PRIMITIVES.md              # 全项目原语（leading words）登记处——翻译前先查这份表
├── DEPENDENCIES.md            # 技能依赖图（分层版）——从主链路视角切入，逐层展开
├── skills/
│   ├── engineering/
│   │   ├── ask-matt/
│   │   │   └── SKILL.md       # 对应 skills/engineering/ask-matt/SKILL.md 的中文翻译
│   │   ├── tdd/
│   │   │   └── SKILL.md
│   │   └── ...
│   └── productivity/
│       ├── grill-me/
│       │   └── SKILL.md
│       └── ...
```

## 翻译原则

1. **不修改原始英文文件**：根目录下的 `.agents/`、`skills/`、`AGENTS.md`、`CLAUDE.md` 等文件保持与上游一致，只做同步（sync fork / merge upstream），不做任何汉化改动，以避免与上游更新产生合并冲突。
2. **逐字翻译**：`zh-CN/` 下的翻译内容力求忠实原文，同时保持中文表达自然流畅；专有名词（如技能名 `/tdd`、`/grill-me` 等命令名）保留英文原名不译。
   - **词汇原语（leading words）**：跨文件共享的原语（如 `frontier`、`seam`、`tracer bullet`）必须保留英文 token，token 选择一律以 [`PRIMITIVES.md`](./PRIMITIVES.md) 登记为准；完整规则见 `.github/copilot-instructions.md` 翻译规范第 3 条。
   - **示例与模板（examples / templates）**：文档中的示例、模板、样板文件（如 triage 的 agent 简报、`.out-of-scope/` 文件、needs-info 评论模板、免责声明等）**保留英文原文**，因为这些内容会被实际发布到 issue 跟踪器或写入项目文档，agent 和外部读者按英文消费。每个保留英文的示例/模板**必须满足**：
     - 前置一行中文说明（blockquote 或正文行），解释这是实际操作产物、按仓库工作语言保留英文；
     - 正文逐段/逐字段配中文译文（以括号 `（...）` 注释、行内 `# 注释` 或紧跟的译文段落呈现），确保中文读者无需阅读原文即可理解。
     - 散文中引用的英文短语/对话话术（如 "Show me anything that needs my attention"）同样保留英文 + 紧跟中文译文括号。
     - 参考实现：`zh-CN/skills/engineering/triage/AGENT-BRIEF.md`、`OUT-OF-SCOPE.md`、`SKILL.md`。
3. **文件级追踪（必须）**：每个 `SKILL.md` 翻译文件必须在 frontmatter 内注明对应英文原文件最近一次改动的 commit **完整** SHA，key 名 `commit_version`，方便判断该翻译是否已经过期、是否需要跟随上游更新重新翻译。源文件路径无需记录（`zh-CN/` 与 `skills/` 目录一一对应，可由翻译文件自身路径去掉 `zh-CN/` 前缀推导）；`README.md`、`openai.yaml` 等其他文件不记录。
   - 写法：在 frontmatter 现有字段之后、结束 `---` 之前加一行 `commit_version: <full-sha>`（frontmatter 多出的字段会被 skill loader 忽略，不影响解析）。
   - 获取 SHA：`git log -1 --format=%H -- <源文件路径>`（`<源文件路径>` 即去掉 `zh-CN/` 前缀后的路径）。
   - 示例：`commit_version: 50777fcc0982d5867997a75a1e0731b9daac94eb`
4. **翻译状态标记**：翻译进度会在下方的“翻译状态清单”中维护，直到有更完善的自动化工具（如 GitHub Actions + Issue 跟踪）接管。
5. **约定同步挂接（维护要求）**：新增或修改翻译约定时，必须同步挂接（或以引用方式挂接）到全部四处：本文件（翻译原则）、`.github/copilot-instructions.md`（翻译规范）、`.github/agents/zh-cn-translator.md`、`.pi/prompts/zh-cn-translator.md`。后两者是实际执行翻译的 agent/prompt，它们只读自己的 prompt 文件——约定只写在一处等于没写。

## 翻译状态清单

| 分类 | 状态 | 说明 |
| --- | --- | --- |
| README.md（仓库总览） | 已完成 | 已翻译为 [`README.repo.md`](./README.repo.md)（因 `zh-CN/README.md` 被本追踪文档占用，仓库总览的翻译使用此文件名） |
| skills/engineering/* | 已完成 | 已全部翻译（`README.md` 及全部 18 个技能：`ask-matt`、`code-review`、`codebase-design`、`diagnosing-bugs`、`domain-modeling`、`grill-with-docs`、`implement`、`improve-codebase-architecture`、`prototype`、`research`、`resolving-merge-conflicts`、`setup-matt-pocock-skills`、`to-spec`、`to-tickets`、`triage`、`tdd`、`wayfinder`、`wizard`），各 `SKILL.md` 均已添加 `commit_version` 追踪字段 |
| skills/productivity/* | 已完成 | 已全部翻译（`README.md`、`grill-me`、`grilling`、`handoff`、`teach`、`to-questionnaire`、`wait-what`、`writing-for-agents`），各 `SKILL.md` 均已添加 `commit_version` 追踪字段 |
| skills/misc/* | 已完成 | 已全部翻译（`README.md`、`git-guardrails-claude-code`、`migrate-to-shoehorn`、`scaffold-exercises`、`setup-pre-commit`），各 `SKILL.md` 均已添加 `commit_version` 追踪字段 |
| skills/in-progress/* | 已完成 | 已全部翻译（`README.md`、`claude-handoff`、`loop-me`、`setup-ts-deep-modules`、`writing-beats`、`writing-fragments`、`writing-shape`），各 `SKILL.md` 均已添加 `commit_version` 追踪字段 |
| skills/deprecated/* | 已完成 | 已翻译（仅 `README.md`；该桶当前为空） |

> 本清单会随着翻译进度持续更新。
