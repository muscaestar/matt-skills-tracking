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
3. **文件级追踪**：每个翻译文件顶部会注明对应英文原文件的 commit SHA（或版本号），方便判断该翻译是否已经过期，是否需要跟随上游更新重新翻译。
4. **翻译状态标记**：翻译进度会在下方的“翻译状态清单”中维护，直到有更完善的自动化工具（如 GitHub Actions + Issue 跟踪）接管。

## 翻译状态清单

| 分类 | 状态 | 说明 |
| --- | --- | --- |
| README.md（仓库总览） | 待翻译 | 尚未开始 |
| skills/engineering/* | 待翻译 | 尚未开始 |
| skills/productivity/* | 部分完成 | 已完成 `README.md`、`wait-what/SKILL.md`、`wait-what/agents/openai.yaml`；其余待翻译 |
| skills/misc/* | 待翻译 | 尚未开始 |
| skills/deprecated/* | 待翻译 | 尚未开始 |

> 本清单会随着翻译进度持续更新。
