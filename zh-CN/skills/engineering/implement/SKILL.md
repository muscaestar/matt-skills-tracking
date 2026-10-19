---
name: implement
description: "基于规格说明或一组 ticket 实现一项工作。"
disable-model-invocation: true
commit_version: 6d6a5b9072f47ee7ba1d972d8ce0ee98b7ed4394
---

实现用户在规格说明或 ticket 中描述的工作。

如果用户传入了一个 ticket 引用，先从 issue 跟踪器取出它，并在开始前说明它的标题。如果引用有歧义，先问清楚。

在可能的地方调用 Skill 工具的 "tdd"，并在预先商定的 seam 处进行。

定期运行类型检查，定期运行单个测试文件，最后运行一次完整测试套件。

完成后，调用 Skill 工具的 "code-review" 审查这项工作。

把工作提交到当前分支。
