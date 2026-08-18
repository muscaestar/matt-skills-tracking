---
name: writing-fragments
description: 写作之 explore——开采原始碎片，还没有结构。
disable-model-invocation: true
commit_version: 78636f8e5c045d0d9e5731add3fdba3583e9b2af
---

<what-to-do>

这是纯粹的 **explore**：拓宽可写内容的空间而不锁定结构——锁定是 _exploit_，另一个技能的工作。运行一场产出碎片的 grilling 会话，围绕用户想写的任何东西穷追不舍地访谈他们。强加阶段、大纲或文章结构超出了这里的范围。

随着碎片从对话的任何一侧浮现，把它们追加到单个 markdown 文件中。

如果用户没有传入路径，问一次文档保存在哪里，然后在会话剩余时间里记住它。

从用户说的第一句话起就开始捕获碎片，包括最初的提示词。

第一次写入时，在顶部放单个 H1 作为工作标题（之后可以改），其他什么都不要——没有元数据、没有目录、没有日期。

</what-to-do>

<supporting-info>

## 什么是碎片

碎片是任何可能留存到最终文章中的文本片段。它必须*作者可读*——作者能看懂它的意思——但它不需要定义自己的术语，也不需要让陌生读者读得懂。标准是"这是一段好文字吗？"，而不是"这是一个自足的论证吗？"

碎片刻意是异构的。可以成为碎片的例子：

- 一句你想用在某处但还不知道用在哪里的锋利的话。
- 一个带一行理由的论断。
- 一个小品：一件发生的事、一段代码、一个场景、一个类比。
- 半个想法："something about how X feels like Y, work this out later."
- 一段引文、一段对话、一句偶然听到的话。
- 一组凭感觉聚在一起的相关观察。
- 一句抱怨、一段自白、一个包袱。
- 一个**主导词（leading word）**——一个整篇文章可以挂在上面的紧凑隐喻或造词（一个命名了想法的术语，就像 _tracer bullets_ 或 _fog of war_ 命名了整个模式）。

其中，主导词是最值得落地的碎片。它是承重的：在 explore 阶段造出正确的那个词，之后它会塑造结构、过渡和标题——在整个 exploit 阶段持续带来回报。当对话围绕一个反复出现的想法打转时，推动为它造一个词。

小说家的日记是范本：多年无结构的观察记录，之后被开采为原始素材。碎片就是观察记录。

## 文件格式

```markdown
# Working title

A first fragment lives here.

It can be multiple paragraphs. It can include lists, code, quotes — whatever
shape the fragment naturally takes.

---

A second fragment.

---

> A quoted line that the user wants to keep around.

A reaction to it.

---

- A cluster of related observations
- That hang together by feel
- And want to be near each other
```

碎片之间用水平线（`\n---\n`）分隔。正文中没有标题。没有标签。除了添加顺序之外没有其他顺序。

## 写作节奏

安静地追加。不要为每个碎片请求许可。顺带提及你加了什么（"adding that"），但不要用保存对话框打断对话。

每次写入之前：从磁盘重新阅读文件。用户可能在轮次之间编辑、重排或删除了碎片——保留他们的改动。永远不要覆盖文件；只追加（或者，如果用户要求，就地编辑某个特定碎片）。

用户可以随时说"删掉最后一条"、"把那条改得更锋利"、"把那两条合并"。把这些当作一等指令对待。

</supporting-info>
