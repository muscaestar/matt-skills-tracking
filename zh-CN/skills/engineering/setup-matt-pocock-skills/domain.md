# 领域文档

engineering 技能在探索代码库时应如何消费本仓库的领域文档。

## 探索之前，先读这些

- 仓库根目录的 **`CONTEXT.md`**，或者
- 仓库根目录的 **`CONTEXT-MAP.md`**（如果存在）——它指向每个上下文各自的 `CONTEXT.md`。阅读与你的主题相关的每一个。
- **`docs/adr/`**——阅读涉及你即将动手区域的 ADR。在多上下文仓库中，还要检查 `src/<context>/docs/adr/` 里的上下文级决策。

如果这些文件不存在，**默默继续**。不要指出它们的缺失；不要建议提前创建它们。`/domain-modeling` 技能（经由 `/grill-with-docs` 和 `/improve-codebase-architecture` 触达）会在术语或决策真正得到解答时惰性创建它们。

## 文件结构

单上下文仓库（大多数仓库）：

```
/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

多上下文仓库（根目录存在 `CONTEXT-MAP.md`）：

```
/
├── CONTEXT-MAP.md
├── docs/adr/                          ← 系统级决策
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/                  ← 上下文级决策
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## 使用术语表的词汇

当你的输出命名一个领域概念时（在 issue 标题、重构提案、假设、测试名中），使用 `CONTEXT.md` 中定义的术语。不要漂移到术语表明确避免的同义词。

如果你需要的概念还不在术语表里，这是一个信号——要么你在发明项目并不使用的语言（重新考虑），要么确实存在缺口（记下来交给 `/domain-modeling`）。

## 标记 ADR 冲突

如果你的输出与现有 ADR 相矛盾，显式指出来，而不是悄悄覆盖：

> _与 ADR-0007（event-sourced orders）矛盾——但值得重新讨论，因为……_
