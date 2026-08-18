---
name: setup-pre-commit
description: 在当前仓库中设置 Husky pre-commit hooks，包含 lint-staged（Prettier）、类型检查和测试。当用户想添加 pre-commit hooks、设置 Husky、配置 lint-staged，或添加提交时的格式化/类型检查/测试时使用。
commit_version: 62f43a18177be6ec82da242e59ffbc490a4c22ea
---

# 设置 Pre-Commit Hooks

## 这会设置什么

- **Husky** pre-commit hook
- 对所有暂存文件运行 Prettier 的 **lint-staged**
- **Prettier** 配置（如果缺失）
- pre-commit hook 中的 **typecheck** 和 **test** 脚本

## 步骤

### 1. 检测包管理器

检查 `package-lock.json`（npm）、`pnpm-lock.yaml`（pnpm）、`yarn.lock`（yarn）、`bun.lockb`（bun）。用检测到的那一个。不清楚时默认 npm。

### 2. 安装依赖

以 devDependencies 安装：

```
husky lint-staged prettier
```

### 3. 初始化 Husky

```bash
npx husky init
```

这会创建 `.husky/` 目录并向 package.json 添加 `prepare: "husky"`。

### 4. 创建 `.husky/pre-commit`

写入这个文件（Husky v9+ 不需要 shebang）：

```
npx lint-staged
npm run typecheck
npm run test
```

**适配**：把 `npm` 替换为检测到的包管理器。如果仓库的 package.json 中没有 `typecheck` 或 `test` 脚本，省略对应行并告知用户。

### 5. 创建 `.lintstagedrc`

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

### 6. 创建 `.prettierrc`（如果缺失）

仅在不存在 Prettier 配置时创建。使用这些默认值：

```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

### 7. 验证

- [ ] `.husky/pre-commit` 存在且可执行
- [ ] `.lintstagedrc` 存在
- [ ] package.json 中的 `prepare` 脚本是 `"husky"`
- [ ] `prettier` 配置存在
- [ ] 运行 `npx lint-staged` 验证它能工作

### 8. 提交

暂存所有改动/创建的文件，用以下消息提交：`Add pre-commit hooks (husky + lint-staged + prettier)`

这次提交会经过新的 pre-commit hooks——是验证一切正常的好冒烟测试。

## 备注

- Husky v9+ 的 hook 文件不需要 shebang
- `prettier --ignore-unknown` 跳过 Prettier 无法解析的文件（图片等）
- pre-commit 先运行 lint-staged（快、只针对暂存文件），然后运行完整的类型检查和测试
