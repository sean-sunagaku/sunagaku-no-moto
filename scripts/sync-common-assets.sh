#!/bin/bash
# common/public/ の共通画像を各プロジェクトの public/ に同期するスクリプト
#
# 使い方:
#   ./scripts/sync-common-assets.sh              # 全プロジェクトに同期
#   ./scripts/sync-common-assets.sh aircle        # 指定プロジェクトのみ

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
COMMON_PUBLIC="$REPO_ROOT/common/public"

if [ ! -d "$COMMON_PUBLIC" ]; then
  echo "Error: $COMMON_PUBLIC が見つかりません"
  exit 1
fi

sync_project() {
  local project="$1"
  local project_public="$REPO_ROOT/$project/public"

  mkdir -p "$project_public"

  local copied=0
  for file in "$COMMON_PUBLIC"/*; do
    local filename
    filename="$(basename "$file")"
    if [ ! -f "$project_public/$filename" ] || ! cmp -s "$file" "$project_public/$filename"; then
      cp "$file" "$project_public/$filename"
      copied=$((copied + 1))
    fi
  done

  if [ "$copied" -gt 0 ]; then
    echo "  $project: ${copied} ファイルをコピー"
  else
    echo "  $project: 最新（変更なし）"
  fi
}

# 対象プロジェクトの特定
if [ $# -gt 0 ]; then
  # 引数で指定されたプロジェクト
  projects=("$@")
else
  # package.json があるディレクトリ = Slidev プロジェクト
  projects=()
  for pkg in "$REPO_ROOT"/*/package.json; do
    dir="$(basename "$(dirname "$pkg")")"
    [ "$dir" = "common" ] && continue
    projects+=("$dir")
  done
fi

echo "common/public/ → 各プロジェクトの public/ に同期"
echo ""

for project in "${projects[@]}"; do
  sync_project "$project"
done

echo ""
echo "完了"
