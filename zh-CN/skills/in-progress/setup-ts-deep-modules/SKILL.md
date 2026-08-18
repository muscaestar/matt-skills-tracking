---
name: setup-ts-deep-modules
description: 把 dependency-cruiser 接入 TypeScript 仓库，让每个包都成为深模块——实现隐藏在子文件夹中，只能通过入口文件触达。用户调用。
disable-model-invocation: true
commit_version: fcf0071560d32913c9d4f820e0d7ca467c881619
---

# 设置 TS 深模块

让本仓库中的每个包都成为**深模块（deep module）**：小接口背后藏着大量行为。包的公开表面是它的**入口点（entry points）**——包根目录下的文件——子文件夹中的一切都是隐藏的。本技能安装 [dependency-cruiser](https://github.com/sverweij/dependency-cruiser) 以及让入口点成为唯一入口的规则，然后证明这些规则真的会咬人。

相关词汇（deep module、interface、seam、depth），调用 Skill 工具并传入 "codebase-design"——全程使用它的语言。

## 这要强制的形状

```
src/packages/
  <name>/
    index.ts        ← 一个入口点（公开）。从外部 import 它。
    client.ts       ← 另一个入口点。包可以暴露多个。
    lib/            ← 实现：对外隐藏，内部互相 import 自由。
    tests/          ← 同放一处的测试 + fixture（是子文件夹，所以是私有的）。
```

公开表面是包的**根文件**——不是某个指定的 `index.ts`。按约定实现放在 `lib/`、测试放在 `tests/`，让每个包都有同样的双文件夹形状。但规则本身是通用的：*任何*子文件夹中的*任何东西*都是私有的，所以你永远不需要为了加一个文件夹而扩展配置。

四条规则，全部为 `error`：

1. **入口点边界**——包外的代码（应用代码或另一个包）只能 import 该包的入口点（它的根文件），永远不能 import 其子文件夹中的任何东西。
2. **包内自由**——包自己的文件之间可以自由互相 import。
3. **测试走入口点**——`<pkg>/tests/` 下的文件可以 import 任何包的入口点和它们自己 `tests/` 的 fixture，但永远不能 import 任何包的子文件夹内部实现（包括它们自己的）。跨包的集成测试没问题；深 import 不行。
4. **禁止循环**——不允许依赖循环。

**入口点，而不是 barrel。** 因为公开表面是*每一个*根文件，一个包可以暴露若干个小入口点（`index.ts`、`client.ts`、`server.ts`），而不是把一切都漏斗式地塞进一个巨大的 `index.ts`。不鼓励 re-export 整个子树的 barrel 文件——保持入口点小而把实现藏进子文件夹。

分层（哪些包可以依赖哪些包）是*另一个*关注点，在配置中以注释掉的存根留给本仓库填写。

## 步骤

### 1. 检测环境

- **包管理器**——`pnpm-lock.yaml` → pnpm，`yarn.lock` → yarn，`bun.lockb` → bun，否则 npm。下面每条命令都用它（`pnpm`/`yarn`/`npm run`/`bunx`）。
- **包根目录**——如果 `src/` 存在就用 `src/packages`，否则用 `packages`。如果仓库已有其他明显约定，与用户确认选择。
- **现有配置**——检查是否有 `.dependency-cruiser.*` 文件。如果存在，**不要**覆盖它：把四条规则和选项合并进去，并告诉用户你添加了什么。

**完成标准：** 包管理器、包根目录和现有配置状态都已知。

### 2. 安装 dependency-cruiser

用检测到的包管理器把 `dependency-cruiser` 安装为 devDependency。

**完成标准：** `dependency-cruiser` 在 `devDependencies` 中。

### 3. 写配置

把 [`dependency-cruiser.config.cjs`](./dependency-cruiser.config.cjs) 复制到仓库根目录，命名为 `.dependency-cruiser.cjs`。把 `PACKAGES_ROOT` 设为第 1 步检测到的根目录。规则基于路径深度、与扩展名无关，所以不需要其他适配。

**完成标准：** `.dependency-cruiser.cjs` 存在且 `PACKAGES_ROOT` 正确，四条 forbidden 规则都在。

### 4. 接入检查流程

- 添加 `lint:boundaries` 脚本：`depcruise <packages-root>`（或 `depcruise src`）。
- 把它并入仓库的总检查命令——那个已经在跑 typecheck 的命令（例如 `check` / `ci` / `validate` 脚本）。**不要**动 `tsconfig`，不要加路径别名。
- 如果没有总检查脚本，添加 `lint:boundaries` 并告诉用户把它纳入 CI。

**完成标准：** `lint:boundaries` 存在，并作为与 typecheck 相同的命令的一部分运行。

### 5. 搭建示例包

创建一个提交的 `<packages-root>/example/` 作为可复制模板：

- `index.ts`——一个入口点。导出一个委托给内部文件的函数（让这个包 visibly *深*，而不是直通转发）。
- `lib/impl.ts`——**子文件夹**中的内部文件，被 `index.ts` import，从外部不可达。
- `tests/example.test.ts`——**只** import `../index`（一个入口点），并对公开函数做断言。

告诉用户这是一个可以复制或删除的起始模板。

**完成标准：** 示例包存在，通过根入口点暴露其行为，并把 `impl` 藏在子文件夹中。

### 6. 证明规则会咬人

这是整个技能的完成标准——一个对违规不失败的配置毫无价值。

1. 运行 `lint:boundaries`。在干净的示例上它必须**通过**。
2. 临时向 `tests/example.test.ts` 添加一个深 import（例如 `import { thing } from "../lib/impl"`）。再次运行 `lint:boundaries`——它必须以 `tests-through-entrypoints` **失败**。
3. 还原这个深 import。再运行一次——它必须**通过**。

**完成标准：** 你观察到了一次通过，然后深 import 失败，然后再次通过。如果第 2 步没有失败，说明规则没有接对——修好再收尾。

### 7. 记录约定

在**包文件夹中**（`<packages-root>/README.md`）写一份 `README.md`——放在它管辖的包旁边——覆盖：`src/packages/<name>/` 布局（入口点在根部，`lib/` 放实现，`tests/` 放测试）、"只能通过包的入口点（它的根文件）import"，以及如何运行 `lint:boundaries`。**明确不鼓励 barrel 文件**——暴露若干小入口点，而不是通过一个 index re-export 整个子树。内容保持为可复制片段加上四条规则各一段话。

然后从仓库的 agent 指示文件添加一个**上下文指针**指向它——有 `CLAUDE.md` 就用它，否则用 `AGENTS.md`（两者都不存在就创建 `AGENTS.md`）。一行就够，例如 `Packages are deep modules — see [src/packages/README.md](./src/packages/README.md) before adding or importing one.` 这正是让 agent 发现边界规则而不是被它绊倒的东西。

**完成标准：** `<packages-root>/README.md` 存在且不鼓励 barrel，且仓库的 `CLAUDE.md`/`AGENTS.md` 链接到它。

## 备注

- 配置的 `$1` 反向引用（dependency-cruiser 的分组匹配）是让包能触达自己内部而外部不能的关键——不要把它们展开成逐包的独立规则。
- 公开还是私有由**深度**决定：包的根文件是入口点；子文件夹中的任何东西都是私有的。约定俗成的子文件夹是 `lib/`（实现）和 `tests/`，但规则并不硬编码它们——任何子文件夹都是私有的，所以新文件夹永远不需要改配置。添加入口点就是添加一个根文件——不需要 barrel。
- 包是**扁平的**：根目录下只有一层直接子级。包的内部想嵌套多深都行；包不能包含另一个包。
- 用 `.cjs`（而不是 `.js`），这样配置的 `module.exports` 在 `"type": "module"` 的仓库中也能工作。
