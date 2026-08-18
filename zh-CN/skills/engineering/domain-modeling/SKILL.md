---
name: domain-modeling
description: 构建并打磨项目的领域模型。当讨论代码库术语、编写或编辑 CONTEXT.md，或记录或编辑 ADR 时使用。
commit_version: 54bc6b604075c18293d38e9e294a2c96f365f104
---

# Domain Modeling

在设计的同时，积极构建和打磨项目的领域模型。这是一种*主动*纪律（active discipline）——挑战术语、发明边界场景，并在它们刚刚成形的瞬间写下术语表和决策。（仅仅*阅读* `CONTEXT.md` 获取词汇不属于本技能——那是任何技能都能做到的一行式习惯。本技能用于你在*改变*模型，而不仅仅是消费模型时。）

## 文件结构

大多数仓库只有一个上下文：

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

如果根目录存在 `CONTEXT-MAP.md`，仓库就有多个上下文。该映射指明每个上下文的位置：

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← context-specific decisions
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

按需创建文件——只有当你有东西要写时才创建。如果没有 `CONTEXT.md`，在第一个术语确定时创建。如果没有 `docs/adr/`，在需要第一个 ADR 时创建。

## 会话期间

### 对照术语表（glossary）提出质疑

当用户使用的术语与 `CONTEXT.md` 中的现有语言冲突时，立即指出。“你的术语表把 'cancellation' 定义为 X，但你似乎指的是 Y——到底是哪个？”

### 打磨模糊语言

当用户使用含糊或重载的术语时，提出一个精确的规范术语。“你说的是 'account'——你是指 Customer 还是 User？它们是不同的东西。”

### 讨论具体场景

在讨论领域关系时，用具体场景做压力测试。发明能探测边界情况的场景，迫使用户把概念之间的边界说精确。

### 与代码交叉核对

当用户说明某件事如何运作时，检查代码是否一致。如果发现矛盾，就把它摆出来：“你的代码会取消整个 Order，但你刚才说部分取消是可能的——哪个才对？”

### 实时更新 CONTEXT.md

术语一确定，就当场更新 `CONTEXT.md`。不要攒成一批——随时发生随时记录。使用 [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md) 中的格式。

`CONTEXT.md` 应当完全不包含实现细节。不要把它当作规格、草稿本或实现决策的存放处。它是术语表（glossary），仅此而已。

### 谨慎提议 ADR

只有以下三点全部成立时才提议创建 ADR：

1. **难以逆转**——日后改变主意的代价是切实的
2. **没有上下文会很意外**——未来的读者会疑惑“他们为什么这么做？”
3. **真实权衡的结果**——确实存在其他选项，而你出于具体理由选了这一个

三点缺一，就跳过 ADR。使用 [ADR-FORMAT.md](./ADR-FORMAT.md) 中的格式。
