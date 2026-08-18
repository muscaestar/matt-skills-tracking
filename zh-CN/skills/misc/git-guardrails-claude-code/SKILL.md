---
name: git-guardrails-claude-code
description: 设置 Claude Code hooks，在危险的 git 命令（push、reset --hard、clean、branch -D 等）执行前拦截它们。当用户想防止破坏性 git 操作、添加 git 安全 hook，或在 Claude Code 中阻止 git push/reset 时使用。
commit_version: 62f43a18177be6ec82da242e59ffbc490a4c22ea
---

# 设置 Git 护栏

设置一个 PreToolUse hook，在 Claude 执行危险 git 命令之前拦截并阻止它们。

## 会被阻止的命令

- `git push`（所有变体，包括 `--force`）
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

被阻止时，Claude 会看到一条消息，告诉它无权执行这些命令。

## 步骤

### 1. 询问范围

问用户：安装到**仅本项目**（`.claude/settings.json`）还是**所有项目**（`~/.claude/settings.json`）？

### 2. 复制 hook 脚本

随附脚本位于：[scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh)

按范围复制到目标位置：

- **项目**：`.claude/hooks/block-dangerous-git.sh`
- **全局**：`~/.claude/hooks/block-dangerous-git.sh`

用 `chmod +x` 赋予可执行权限。

### 3. 把 hook 加入 settings

添加到对应的 settings 文件：

**项目**（`.claude/settings.json`）：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

**全局**（`~/.claude/settings.json`）：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

如果 settings 文件已存在，把 hook 合并进现有的 `hooks.PreToolUse` 数组——不要覆盖其他设置。

### 4. 询问定制需求

问用户是否想在阻止列表中增加或移除任何模式。相应编辑复制后的脚本。

### 5. 验证

跑一个快速测试：

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
```

应以退出码 2 退出，并向 stderr 打印一条 BLOCKED 消息。
