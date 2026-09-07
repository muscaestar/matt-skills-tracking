#!/bin/bash
# 给 zh-CN 下所有无 commit_version 的翻译文件补上追踪字段
# 规则：英文源文件存在 → 补；zh-CN 独有（如 README.md 追踪文档、README.repo.md）→ 跳过
cd /tmp/matt-skills-tracking
find zh-CN -name "*.md" -type f | sort > /tmp/zh_files.txt

added=0; skipped=0
while IFS= read -r zh_file; do
  grep -q '^commit_version:' "$zh_file" && continue

  src_file="${zh_file#zh-CN/}"
  [ -f "$src_file" ] || { echo "SKIP (无英文源): $zh_file"; skipped=$((skipped+1)); continue; }

  sha=$(git rev-list -1 upstream/main -- "$src_file")
  [ -z "$sha" ] && { echo "SKIP (上游无此文件): $zh_file"; skipped=$((skipped+1)); continue; }

  first_line=$(head -1 "$zh_file")
  if [ "$first_line" = "---" ]; then
    # 已有 frontmatter：在第一个 --- 之后插入
    sed -i "1a commit_version: $sha" "$zh_file"
  else
    # 无 frontmatter：在文件头部插入
    sed -i "1i ---\ncommit_version: $sha\n---\n" "$zh_file"
  fi
  echo "ADD: $zh_file -> ${sha:0:7}"
  added=$((added+1))
done < /tmp/zh_files.txt
echo "---"
echo "added=$added skipped=$skipped"
