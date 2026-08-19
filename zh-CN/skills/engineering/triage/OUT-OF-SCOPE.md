---
commit_version: e00eadb4bb32c3d5a631ead1a5ed5d6a7c5f74e2
---

# Out-of-Scope 知识库

仓库中的 `.out-of-scope/` 目录存放被拒绝的功能请求的持久记录。它有两个用途：

1. **机构记忆**——一个功能为什么被拒绝，这样当 issue 关闭后理由不会丢失
2. **去重**——当新 issue 与之前的拒绝相匹配时，技能可以浮现之前的决定，而不是重新争论一遍

## 目录结构

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

每个**概念**一个文件，而不是每个 issue 一个文件。多个请求同一件事的 issue 归在同一个文件下。

## 文件格式

文件应该用轻松、可读的风格撰写——更像一份简短的设计文档，而不是数据库条目。使用段落、代码示例和例子，让第一次读到它的人能清楚理解理由并有所收获。

> 下面的示例文件保留英文——`.out-of-scope/` 文件是写给后续读者（人和 agent）的项目文档，按仓库的工作语言撰写；各段含义见中文注释。

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.
（本项目不支持深色模式或面向用户的主题。）

## Why this is out of scope    # 为什么这超出范围

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:
（渲染管线假定使用 `ThemeConfig` 中定义的单一调色板。
支持多主题将需要：）

- A theme context provider wrapping the entire component tree
  （包裹整个组件树的主题上下文 provider）
- Per-component theme-aware style resolution
  （逐组件的主题感知样式解析）
- A persistence layer for user theme preferences
  （用户主题偏好的持久化层）

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.
（这是一个重大的架构变更，与项目专注于内容创作的方向不符。
主题是下游消费者的关注点——即那些嵌入或再分发输出的人。）

```ts
// The current ThemeConfig interface is not designed for runtime switching:
// （当前的 ThemeConfig 接口并非为运行时切换而设计：）
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
                        // （单一调色板，构建时解析）
  fonts: FontStack;
}
```

## Prior requests    # 历史请求

- #42 — "Add dark mode support"（添加深色模式支持）
- #87 — "Night theme for accessibility"（无障碍夜间主题）
- #134 — "Dark theme option"（深色主题选项）
```

### 命名文件

为概念使用简短的描述性 kebab-case 名称：`dark-mode.md`、`plugin-system.md`、`graphql-api.md`。名称应该足够可辨识，让人浏览目录时不打开文件就能明白什么被拒绝了。

### 撰写理由

理由应该有实质内容——不是"我们不想要这个"，而是为什么。好的理由会引用：

- 项目范围或理念（"本项目专注于 X；主题是下游的关注点"）
- 技术约束（"支持这个需要 Y，这与我们的 Z 架构冲突"）
- 战略决策（"我们选择用 A 而不是 B，因为……"）

理由应该是耐久的。避免引用临时性情况（"我们现在太忙了"）——那不是真正的拒绝，只是推迟。

## 什么时候检查 `.out-of-scope/`

在 triage 期间（第 1 步：收集上下文），阅读 `.out-of-scope/` 中的所有文件。评估新 issue 时：

- 检查请求是否与现有的 out-of-scope 概念匹配
- 匹配按概念相似度，而不是关键字——"night theme" 匹配 `dark-mode.md`
- 如果有匹配，浮现给维护者："这与 `.out-of-scope/dark-mode.md` 类似——我们之前拒绝过这个，因为 [理由]。你的想法还和之前一样吗？"

维护者可以：

- **确认**——新 issue 被追加到现有文件的 "Prior requests" 列表，然后关闭
- **重新考虑**——out-of-scope 文件被删除或更新，issue 走正常的 triage 流程
- **不认同**——这些 issue 相关但不同，继续正常 triage

## 什么时候写入 `.out-of-scope/`

仅当一个 **enhancement**（而不是 bug）被*拒绝*为 `wontfix` 时。这对 enhancement PR 与 issue 完全同样适用——被拒绝的 PR 记录在这里，同样的请求才不会以新代码的形式卷土重来。

当某件事因**已被实现**而关闭为 `wontfix` 时，**不要**写入这里。那是已建成的功能，不是被拒绝的；记录它会用假拒绝污染去重检查。此时关闭评论应指向该功能已存在的位置。

流程：

1. 维护者判定一个功能请求超出范围
2. 检查是否已存在匹配的 `.out-of-scope/` 文件
3. 如果是：把新 issue 追加到 "Prior requests" 列表
4. 如果否：创建一个新文件，包含概念名、决定、理由和第一条历史请求
5. 在 issue 上发布评论解释该决定，并提及 `.out-of-scope/` 文件
6. 以 `wontfix` 标签关闭 issue

## 更新或移除 out-of-scope 文件

如果维护者对之前被拒绝的概念改变了主意：

- 删除该 `.out-of-scope/` 文件
- 技能不需要重新打开旧 issue——它们是历史记录
- 触发这次重新考虑的新 issue 走正常的 triage 流程
