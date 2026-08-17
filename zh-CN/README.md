# zh-CN 中文翻译目录

本目录用于存放 [mattpocock/skills](https://github.com/mattpocock/skills) 的中文翻译内容。

## 目录结构约定

本目录的结构 **与仓库根目录的英文原始结构保持一一对应**，方便对照和后续维护：

```
zh-CN/
├── README.md                  # 本文件
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
3. **文件级追踪（必须）**：每个 `SKILL.md` 翻译文件必须在 frontmatter 内注明对应英文原文件最近一次改动的 commit **完整** SHA，key 名 `commit_version`，方便判断该翻译是否已经过期、是否需要跟随上游更新重新翻译。源文件路径无需记录（`zh-CN/` 与 `skills/` 目录一一对应，可由翻译文件自身路径去掉 `zh-CN/` 前缀推导）；`README.md`、`openai.yaml` 等其他文件不记录。
   - 写法：在 frontmatter 现有字段之后、结束 `---` 之前加一行 `commit_version: <full-sha>`（frontmatter 多出的字段会被 skill loader 忽略，不影响解析）。
   - 获取 SHA：`git log -1 --format=%H -- <源文件路径>`（`<源文件路径>` 即去掉 `zh-CN/` 前缀后的路径）。
   - 示例：`commit_version: 50777fcc0982d5867997a75a1e0731b9daac94eb`
4. **翻译状态标记**：翻译进度会在下方的“翻译状态清单”中维护，直到有更完善的自动化工具（如 GitHub Actions + Issue 跟踪）接管。

## 翻译状态清单

| 分类 | 状态 | 说明 |
| --- | --- | --- |
| README.md（仓库总览） | 待翻译 | 尚未开始 |
| skills/engineering/* | 待翻译 | 尚未开始 |
| skills/productivity/* | 已完成 | 已全部翻译（`README.md`、`grill-me`、`grilling`、`handoff`、`teach`、`to-questionnaire`、`wait-what`、`writing-for-agents`），各 `SKILL.md` 均已添加 `commit_version` |
| skills/misc/* | 待翻译 | 尚未开始 |
| skills/deprecated/* | 待翻译 | 尚未开始 |

> 本清单会随着翻译进度持续更新。
