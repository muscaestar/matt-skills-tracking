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

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
- #134 — "Dark theme option"
```

### 命名文件

为概念使用简短的描述性 kebab-case 名称：`dark-mode.md`、`plugin-system.md`、`graphql-api.md`。名称应该足够可辨识，让人浏览目录时不打开文件就能明白什么被拒绝了。

### 撰写理由

理由应该有实质内容——不是 "we don't want this"，而是为什么。好的理由会引用：

- 项目范围或理念（"This project focuses on X; theming is a downstream concern"）
- 技术约束（"Supporting this would require Y, which conflicts with our Z architecture"）
- 战略决策（"We chose to use A instead of B because..."）

理由应该是耐久的。避免引用临时性情况（"we're too busy right now"）——那不是真正的拒绝，只是推迟。

## 什么时候检查 `.out-of-scope/`

在 triage 期间（第 1 步：收集上下文），阅读 `.out-of-scope/` 中的所有文件。评估新 issue 时：

- 检查请求是否与现有的 out-of-scope 概念匹配
- 匹配按概念相似度，而不是关键字——"night theme" 匹配 `dark-mode.md`
- 如果有匹配，浮现给维护者："This is similar to `.out-of-scope/dark-mode.md` — we rejected this before because [reason]. Do you still feel the same way?"

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
