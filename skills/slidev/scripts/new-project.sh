#!/bin/bash
# 新規 Slidev プロジェクトを作成するスクリプト
#
# 使い方:
#   ./scripts/new-project.sh my_new_lt

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -eq 0 ]; then
  echo "使い方: $0 <プロジェクト名>"
  echo "例:     $0 my_new_lt"
  exit 1
fi

PROJECT_NAME="$1"
PROJECT_DIR="$REPO_ROOT/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
  echo "Error: $PROJECT_DIR は既に存在します"
  exit 1
fi

echo "新規プロジェクト作成: $PROJECT_NAME"
echo ""

# ディレクトリ作成
mkdir -p "$PROJECT_DIR/public"
echo "  ディレクトリ作成: $PROJECT_NAME/"

# 共通画像コピー
cp "$REPO_ROOT/common/public/"* "$PROJECT_DIR/public/"
echo "  共通画像コピー: common/public/ → $PROJECT_NAME/public/"

# global-bottom.vue コピー（ページ番号表示）
cp "$REPO_ROOT/common/global-bottom.vue" "$PROJECT_DIR/global-bottom.vue"
echo "  global-bottom.vue コピー"

# package.json
cat > "$PROJECT_DIR/package.json" << 'PACKAGE'
{
  "name": "PROJECT_NAME_PLACEHOLDER",
  "type": "module",
  "private": true,
  "scripts": {
    "build": "slidev build",
    "dev": "slidev --open",
    "export": "slidev export"
  },
  "dependencies": {
    "@slidev/cli": "^52.11.3",
    "@slidev/theme-default": "latest",
    "@slidev/theme-seriph": "latest",
    "vue": "^3.5.26"
  }
}
PACKAGE
sed -i '' "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/" "$PROJECT_DIR/package.json"
echo "  package.json 作成"

# slides.md テンプレート
cat > "$PROJECT_DIR/slides.md" << SLIDES
---
theme: seriph
title: プレゼンテーションタイトル
class: text-center
transition: slide-left
mdc: true
colorSchema: light
background: '#ffffff'
---

<style>
.slidev-page {
  background-color: #ffffff !important;
}
h1 {
  color: #4a6b8a !important;
}
.slidev-layout {
  padding-top: 1.5rem !important;
}
</style>

# プレゼンテーションタイトル

発表者名

---
src: ../common/self-intro.md
---

---

# スライド内容

ここにコンテンツを記述

---
src: ../common/thanks.md
---
SLIDES
echo "  slides.md テンプレート作成"

# pnpm install
echo ""
echo "依存関係をインストール中..."
cd "$PROJECT_DIR" && pnpm install
echo ""
echo "完了! 以下で開発サーバーを起動できます:"
echo "  cd $PROJECT_NAME && pnpm dev"
