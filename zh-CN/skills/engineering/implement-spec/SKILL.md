---
name: implement-spec
description: "把 /to-spec 和 /to-tickets 的结果实现为代码。"
disable-model-invocation: true
commit_version: c612defa9e5cf9372262d0279eb124993ba77b71
---

你已被提供一份 spec。这份 spec 应当关联着一组 ticket，描述如何实现该 spec。

issue 跟踪器应当已经提供给你了。如果没有，告诉用户运行 `/setup-matt-pocock-skills`。

目标是把整个 spec 实现在一条单独的**集成分支（integration branch）**上，每个 ticket 都以 issue 跟踪器关闭工作的方式被解决。

这些 ticket 不是一份步骤清单。它们是一张带有阻塞关系的**任务图（task graph）**。这意味着始终存在一个可以随时抓取的 ticket **frontier**。

与子 agent 之间的通信应当稀疏。主要通过**上下文指针**通信：指向 spec、ticket、研究笔记和之前的 commit。不要复制已经能通过指针获得的信息。

**实现者 subagent（implementer subagent）**应当尽可能在后台运行，以获得最大并发。

## 步骤

1. 阅读 spec 和 ticket，理解任务图。

2. （可选）使用一个**探索 subagent（exploration subagent）**进行 ticket 所需的任何探索——相关代码库文件或外部文档。确保探索 subagent 能保存文件——它应把 markdown 笔记保存在仓库之外、所有后续 subagent 都能访问的目录中。这样**实现者 subagent** 就能专注于实现而不是探索。

3. 创建集成分支。如果 issue 跟踪器通过 PR 关闭工作，或用户要求 PR，在第 5 步的第一次合并之后开一个 draft PR（没有领先 main 任何 commit 的分支开不了 PR），标记为关闭该 spec 和这些 ticket。

4. 使用**实现者 subagent**实现每个 ticket，每个都在自己的 worktree、自己的分支上。每个实现者 subagent：
   - 开始前确认自己的 worktree 基于集成分支，如果不是就 reset 到集成分支上；
   - 调用 Skill 工具获取 `tdd`，用 TDD 构建该 ticket；
   - 在报告完成之前，把集成分支的最新 tip 合并进自己的分支。

5. 一个**实现者 subagent**完成后，用一个**合并者 subagent（merger subagent）**把它的工作合并到集成分支。

6. 如果这改变了可用 ticket 的 **frontier**，就启动更多**实现者 subagent**去处理新 ticket。这样能获得最大并发。

7. 所有 ticket 完成后，在集成分支上调用 Skill 工具获取 `code-review`。用一个单独的**实现者 subagent**修复代码审查提出的所有问题。

8. 如果存在 draft PR，把它标记为 ready for review。否则，以 issue 跟踪器关闭工作的方式解决每个 ticket，并报告集成分支。

9. 清理所有**实现者 subagent**的 worktree。
