#!/bin/bash
# 列出所有 STALE 文件，附 diff 行数，按改动量升序
cd /tmp/matt-skills-tracking
OUT=/tmp/stale-diffs; mkdir -p $OUT
bash scripts/compare-translations.sh | awk '$NF=="STALE"{print $1}' | while read -r zh; do
  src="${zh#zh-CN/}"
  base=$(grep -m1 '^commit_version:' "$zh" | awk '{print $2}')
  latest=$(git rev-list -1 upstream/main -- "$src")
  safe=$(echo "$src" | tr '/' '_')
  git diff "$base" "$latest" -- "$src" > "$OUT/$safe.diff"
  n=$(grep -cE '^[+-]' "$OUT/$safe.diff")
  echo "$n $zh"
done | sort -n
