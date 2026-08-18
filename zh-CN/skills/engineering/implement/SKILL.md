---
name: implement
description: "基于规格说明或一组 ticket 实现一项工作。"
disable-model-invocation: true
commit_version: 386d4ff719a7c420ad1454232d0436b01f1b8c17
---

实现用户在规格说明或 ticket 中描述的工作。

在可能的地方使用 /tdd，并在预先商定的 seam 处进行。

定期运行类型检查，定期运行单个测试文件，最后运行一次完整测试套件。

完成后，使用 /code-review 审查这项工作。

把工作提交到当前分支。
