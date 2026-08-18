---
name: resolving-merge-conflicts
description: "当你需要解决进行中的 git merge/rebase 冲突时使用。"
commit_version: 81ddacb08b3878d07ac4fa2de60bd8a53bacba5b
---

1. **查看 merge/rebase 的当前状态**。检查 git 历史，以及发生冲突的文件。

2. **为每个冲突找到第一手来源**。深入理解每一处改动为什么这样做、最初的意图是什么。阅读提交消息，查看相关 PR，查看原始 issue/ticket。

3. **逐个解决每个冲突块（hunk）**。尽可能同时保留双方的意图。如果两者互不兼容，选择符合本次 merge 既定目标的那个，并注明所做的取舍。**不要**发明新行为。始终完成解决；永远不要 `--abort`。

4. 找到项目的**自动化检查**并运行——通常是先 typecheck，再测试，再格式化。修复 merge 引入的任何问题。

5. **完成 merge/rebase**。暂存所有内容并提交。如果是 rebase，则持续执行 rebase 流程直到所有提交都 rebase 完毕。
