#!/bin/bash
# 比对 zh-CN 翻译的 commit_version 与上游源文件最新 SHA
cd /tmp/matt-skills-tracking

printf "%-55s %-42s %s\n" "TRANSLATION" "SOURCE" "STATUS"
printf '%.0s-' {1..130}; echo

find zh-CN -name "*.md" -type f | sort > /tmp/zh_files.txt

while IFS= read -r zh_file; do
  # 提取 commit_version
  sha=$(grep -m1 '^commit_version:' "$zh_file" | awk '{print $2}')
  [ -z "$sha" ] && { printf "%-55s %-42s %s\n" "$zh_file" "-" "NO_SHA"; continue; }

  # 推导对应的英文源文件路径
  src_file="${zh_file#zh-CN/}"
  if [ ! -f "$src_file" ]; then
    printf "%-55s %-42s %s\n" "$zh_file" "$src_file" "SOURCE_GONE"
    continue
  fi

  # 上游该文件最后修改的 commit
  upstream_sha=$(git rev-list -1 upstream/main -- "$src_file" 2>/dev/null)
  if [ -z "$upstream_sha" ]; then
    printf "%-55s %-42s %s\n" "$zh_file" "$src_file" "NOT_IN_UPSTREAM"
    continue
  fi

  if [ "$upstream_sha" = "$sha" ]; then
    status="OK"
  else
    # commit_version 是否仍是上游历史中该文件的某个版本
    if git merge-base --is-ancestor "$sha" "$upstream_sha" 2>/dev/null; then
      status="STALE"
    else
      status="SHA_UNKNOWN"
    fi
  fi
  printf "%-55s %-42s %s\n" "$zh_file" "$src_file" "$status"
done < /tmp/zh_files.txt

# （文件列表在下方生成，避免 iSH 无 /dev/fd 导致 process substitution 失败）
