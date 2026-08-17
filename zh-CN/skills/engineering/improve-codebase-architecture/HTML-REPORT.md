# HTML 报告格式

架构审查渲染为操作系统临时目录中的单个自包含 HTML 文件。Tailwind 和 Mermaid 都来自 CDN。Mermaid 可靠地处理图形结构图示；手工 div 和内联 SVG 处理更有编辑感的视觉（体量图、剖面图）。两者混用——不要什么都靠 Mermaid，那样会开始显得千篇一律。

## 脚手架

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review — {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      /* small custom layer for things Tailwind doesn't cover cleanly:
         dashed seam lines, hand-drawn-feeling arrow heads, etc. */
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## 头部

仓库名、日期，以及紧凑图例：实线框 = 模块，虚线 = 接缝，红色箭头 = 泄漏，深色粗框 = 深模块。不要写介绍段落——直接进入候选。

## 候选卡片

图示承担主要分量。文字稀疏、平实，直接使用术语表术语（来自 `/codebase-design` 技能），不加修饰。

每个候选是一个 `<article>`：

- **Title**——简短，点明这次深化（例如 “Collapse the Order intake pipeline”）。
- **Badge row**——推荐强度（`Strong` = 祖母绿，`Worth exploring` = 琥珀色，`Speculative` = 石板灰），外加依赖类别标签（`in-process`、`local-substitutable`、`ports & adapters`、`mock`）。
- **Files**——等宽字体列表，`font-mono text-sm`。
- **Before / After diagram**——核心。两栏并排。见下方模式。
- **Problem**——一句话。痛点是什么。
- **Solution**——一句话。改变什么。
- **Wins**——要点，每条 ≤6 个词。例如 “Tests hit one interface”、“Pricing logic stops leaking”、“Delete 4 shallow wrappers”。
- **ADR callout**（如适用）——琥珀色框中的一行字。

不要大段解释。如果图需要一段文字才能看懂，就重画这张图。

## 图示模式

选择适合该候选的模式。混用它们。不要让每张图看起来都一样——多样性本身就是目的之一。

### Mermaid 图（依赖 / 调用流的主力）

当重点是 “X 调用 Y 再调用 Z，看看这团乱麻” 时，用 Mermaid `flowchart` 或 `graph`。用 Tailwind 样式的卡片包起来，避免显得突兀。用 classDef 把泄漏边染红，把深模块染深。序列图适合 “改前：6 次往返；改后：1 次”。

```html
<div class="rounded-lg border border-slate-200 bg-white p-4">
  <pre class="mermaid">
    flowchart LR
      A[OrderHandler] --> B[OrderValidator]
      B --> C[OrderRepo]
      C -.leak.-> D[PricingClient]
      classDef leak stroke:#dc2626,stroke-width:2px;
      class C,D leak
  </pre>
</div>
```

### 手工框线图（当 Mermaid 的布局跟你作对时）

模块用带边框和标签的 `<div>`。箭头用绝对定位在相对容器上的内联 SVG `<line>` 或 `<path>`。当你希望“改后”图呈现为一个粗边框深模块、内部灰显时，用这种——Mermaid 渲染不出那种分量。

### 剖面图（适合分层式浅度）

堆叠水平条带（`h-12 border-l-4`）展示一次调用穿过的各层。改前：6 个细层，每层什么都不做。改后：1 个粗条带，标注合并后的职责。

### 体量图（适合“接口和实现一样宽”）

每个模块两个矩形——一个表示接口表面积，一个表示实现。改前：接口矩形几乎和实现矩形一样高（浅）。改后：接口矩形矮，实现矩形高（深）。

### 调用图折叠

改前：嵌套盒子呈现的函数调用树。改后：同一棵树折叠成一个盒子，如今已内部化的调用在盒内淡显。

## 样式指南

- 偏编辑感，不是公司仪表盘。留白大方。标题可选衬线字体（`font-serif` 与 stone/slate 很搭）。
- 颜色克制：一种强调色（祖母绿或靛蓝），红色用于泄漏，琥珀色用于警告。
- 图示高度保持约 320px，让改前/改后无需滚动即可并排放下。
- 图示内模块标签用 `text-xs uppercase tracking-wider`——它们应当读起来像示意图，而不是 UI。
- 唯一脚本是 Tailwind CDN 和 Mermaid ESM 导入。除此之外报告是静态的——除 Mermaid 自身渲染外没有应用代码，没有交互。

## Top recommendation 栏目

一张更大的卡片。候选名、一句话理由、指向其卡片的锚点链接。仅此而已。

## 语气

平实、简洁——但架构名词和动词直接来自 `/codebase-design` 技能。简洁不是偏离术语的借口。

**必须使用：** module、interface、implementation、depth、deep、shallow、seam、adapter、leverage、locality。

**绝不替代：** component、service、unit（代替 module）· API、signature（代替 interface）· boundary（代替 seam）· layer、wrapper（当你想说 module 时）。

**符合这种风格的措辞：**

- “Order intake module is shallow — interface nearly matches the implementation.”
- “Pricing leaks across the seam.”
- “Deepen: one interface, one place to test.”
- “Two adapters justify the seam: HTTP in prod, in-memory in tests.”

**Wins 要点**用术语表术语点名收益：*“locality: bugs concentrate in one module”*、*“leverage: one interface, N call sites”*、*“interface shrinks; implementation absorbs the wrappers”*。不要写 *“easier to maintain”* 或 *“cleaner code”*——这些术语不在术语表里，也没有存在的资格。

不要骑墙，不要清嗓子，不要 “it's worth noting that…”。能变成要点的话就变成要点；能砍掉的就砍掉；如果术语不在 `/codebase-design` 术语表里，先找一个表内术语，再造新词。
