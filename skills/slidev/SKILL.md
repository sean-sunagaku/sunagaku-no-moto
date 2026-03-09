---
name: slidev
description: >
  Slidev（マークダウンベース）でスナガク流のプレゼンテーションを作成・編集する際のガイドライン。
  グラデーションタイトル、border-leftカードパターン、3色カラーパレット、共通アセット管理を網羅。
  構文、レイアウト、スタイリング、アニメーション、デザインパターンを含む。
  Use when: Slidevスライドを作成・編集するとき。slides.mdを書くとき。
  プレゼン資料を作るとき。LT資料を作成するとき。
  Triggers: "Slidev", "slidev", "スライド作成", "プレゼン作成", "slides.md",
  "LT資料", "プレゼンテーション", "スライド編集", "slidev export"
---

# Slidev Skills（スナガク流）

Slidevはマークダウンベースのプレゼンテーションツール。Vue、Vite、UnoCSSなどのWeb技術を活用し、開発者向けのスライド作成が可能。

このスキルはスナガクが実際のLTで使用しているデザインパターン・テンプレート・アセットを完全に再現するためのガイドライン。

## 基本コマンド

```bash
# 開発サーバー起動
pnpm slidev

# PDF/PPTX/PNG エクスポート
pnpm slidev export

# 静的サイトビルド
pnpm slidev build

# フォーマット
pnpm slidev format
```

## ディレクトリ構造

```
your-slidev/
├── components/       # カスタムコンポーネント (*.vue,*.tsx)
├── layouts/          # カスタムレイアウト
├── public/           # 静的アセット（画像など）
├── setup/            # カスタムセットアップ
├── snippets/         # コードスニペット
├── styles/           # カスタムスタイル
├── slides.md         # メインスライド
└── uno.config.ts     # UnoCSS設定
```

## 初回セットアップ（新規 Slidev リポジトリ）

このスキルには以下のテンプレートとアセットが同梱されている。新規リポジトリで使う場合は以下の手順で配置する。

### 1. リポジトリのルートに `common/` を作成

```bash
mkdir -p common/public
```

### 2. テンプレートファイルをコピー

このスキルの `templates/` ディレクトリから以下をコピーする:

| ソース（スキル内） | コピー先 |
|---|---|
| `templates/self-intro.md` | `common/self-intro.md` |
| `templates/thanks.md` | `common/thanks.md` |
| `templates/global-bottom.vue` | `common/global-bottom.vue` |
| `templates/public/*`（全画像） | `common/public/` |

```bash
# スキルのテンプレートディレクトリパスを確認して実行
SKILL_DIR="<このスキルのディレクトリパス>"
cp "$SKILL_DIR/templates/self-intro.md" common/self-intro.md
cp "$SKILL_DIR/templates/thanks.md" common/thanks.md
cp "$SKILL_DIR/templates/global-bottom.vue" common/global-bottom.vue
cp "$SKILL_DIR/templates/public/"* common/public/
```

### 3. スクリプトをコピー

```bash
mkdir -p scripts
cp "$SKILL_DIR/scripts/new-project.sh" scripts/new-project.sh
cp "$SKILL_DIR/scripts/sync-common-assets.sh" scripts/sync-common-assets.sh
chmod +x scripts/*.sh
```

### 4. 新規プロジェクト作成

```bash
./scripts/new-project.sh my_new_lt
```

以下を自動で行う:
- ディレクトリ作成 + `public/` に共通画像コピー
- `package.json` 生成（slidev + seriph テーマ）
- `slides.md` テンプレート生成（自己紹介・ご清聴スライド込み）
- `pnpm install` 実行

## 共通アセット

リポジトリでは `common/` に共通スライドと画像を集約する。

### 共通スライド

`common/self-intro.md`（自己紹介）と `common/thanks.md`（ご清聴）を各プロジェクトの slides.md から読み込む:

```yaml
---
src: ../common/self-intro.md
---
```

Thanks スライドにプロジェクト固有の QR コードやリンクを追加したい場合は、`src: ../common/thanks.md` を使わずにインラインで書く。共通の thanks.md は変更しない。

### 共通 Vue コンポーネント

`common/global-bottom.vue`（ページ番号表示）をベースファイルとして置いている。
Slidev の仕様上、各プロジェクトのルートに `global-bottom.vue` を配置する必要がある（common から自動読み込みは不可）。
新規プロジェクト作成時は `common/global-bottom.vue` をプロジェクトルートにコピーする。

### 共通画像の同期

共通スライドは `/profile.jpg`, `/x_qr.png`, `/Lovady.png`, `/focus_one.png`, `/focusone_logo.svg`, `/github-claudecode-plugin.png` を参照する。
これらは各プロジェクトの `public/` に存在する必要がある。

**同期スクリプト** (`scripts/sync-common-assets.sh`):

```bash
# 全プロジェクトに同期
./scripts/sync-common-assets.sh

# 特定プロジェクトのみ
./scripts/sync-common-assets.sh aircle
```

差分がある場合のみコピーし、最新なら何もしない。

**注意**: プロジェクト固有の画像は直接 `<project>/public/` に配置する。`common/public/` には全プロジェクト共通のもののみ置く。

## ワークフロー

スライドを作成・編集する際:

1. **共通アセット確認**: `./scripts/sync-common-assets.sh <project>` で共通画像を同期
2. **構文確認**: [references/syntax.md](references/syntax.md) でマークダウン構文・レイアウト・アニメーションを確認
3. **パターン適用**: [references/patterns.md](references/patterns.md) でよく使うスライドパターンを参照
4. **スタイル設定**: [references/styling.md](references/styling.md) で推奨カスタムスタイルを適用
5. **問題解決**: [references/troubleshooting.md](references/troubleshooting.md) でよくある不具合を確認

## クイックリファレンス

### スライド区切り

空行 + `---` + 空行でスライドを分割。

### ヘッドマター（全体設定）

ファイル先頭のフロントマターは全体設定。スナガク流の標準設定:

```yaml
---
theme: seriph
title: プレゼンテーションタイトル
class: text-center
transition: slide-left
mdc: true
colorSchema: light
background: '#ffffff'
---
```

### グローバルスタイル（必須）

ヘッドマター直後に以下の `<style>` を配置:

```html
<style>
.slidev-page {
  background-color: #ffffff !important;
}
h1 {
  color: #4a6b8a !important;
}
h1 + div, h1 + p {
  margin-top: 2rem !important;
}
.slidev-layout {
  padding-top: 1.5rem !important;
}
</style>
```

### レイアウト一覧

- `default`, `center`, `cover`, `intro`, `section`, `quote`, `end`, `full`
- `two-cols`, `two-cols-header`, `image-left`, `image-right`

### デザインの鉄則

1. コンテンツの縦位置は `margin-top` で調整する
2. 画像は必ず `public/` に配置してから参照する
3. 項目数に応じて padding / margin / font-size を調整する
4. 2カラムは `grid-cols-2` より `grid-template-columns` で比率指定する
5. h1 に `position: relative; top: ...` で上にずらすスタイルは使わない
6. スライド下部にキャッチフレーズ的なまとめ文を入れない。カード項目だけで完結させる
7. 画像の位置調整は `position: relative; top: ...; right: ...` を使う。margin で調整しない

## タイトルスライド（スナガク流）

毎回同じ構造を使う。タイトルはグラデーション、著者名は `absolute top-90` で下部に配置:

```html
<div class="relative z-10 h-full flex flex-col items-center justify-center" style="padding-top: 60px; padding-bottom: 60px; background-color: #ffffff;">

<div class="mb-2" style="font-size: 1.1rem; font-weight: 500; letter-spacing: 0.2em; color: #7a6b8a;">
イベント名
</div>

<div style="font-size: 2.2rem; font-weight: 800; line-height: 1.3; text-align: center; background: linear-gradient(135deg, #1e293b 0%, #4a6b8a 50%, #7a6b8a 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
メインタイトル
</div>

<div style="margin-top: 1rem; font-size: 1.2rem; font-weight: 500; color: #64748b; letter-spacing: 0.05em;">
― サブタイトル ―
</div>

<div class="absolute top-90" style="text-align: center; font-size: 1rem; font-weight: 500; color: #475569;">
  スナガク
</div>

</div>
```

### タイトル文字サイズの調整

- 短いタイトル（1行）: `font-size: 2.8rem`
- 普通のタイトル（1〜2行）: `font-size: 2.2rem`
- 長いタイトル（2行+サブ）: `font-size: 2rem`

## カードスタイルパターン

コンテンツスライドでは border-left 付きカードで項目を並べる。3色（`#4a6b8a`, `#7a6b8a`, `#8a6b7a`）を順に使う。4つ目以降は `#64748b` → `#4a6b8a`（ループ）。

### 標準カード（タイトル + サブテキスト）

```html
<div style="padding: 1.5rem; border-left: 4px solid #4a6b8a; margin-bottom: 1.5rem;">
  <div style="font-size: 1.3rem; font-weight: 600; color: #4a6b8a; margin-bottom: 0.3rem;">タイトル行</div>
  <div style="font-size: 0.95rem; color: #64748b;">補足テキスト</div>
</div>
```

### コンパクトカード（項目が多い場合）

```html
<div style="padding: 1rem; border-left: 4px solid #4a6b8a; margin-bottom: 0.8rem;">
  <div style="font-size: 1.2rem; font-weight: 600; color: #4a6b8a; margin-bottom: 0.3rem;">タイトル行</div>
  <div style="font-size: 0.95rem; color: #64748b;">補足テキスト</div>
</div>
```

### タイトルのみカード（1行）

```html
<div style="padding: 1.5rem; border-left: 4px solid #8a6b7a;">
  <div style="font-size: 1.3rem; font-weight: 600; color: #8a6b7a; margin-bottom: 0.3rem;">タイトル行のみ</div>
</div>
```

### テキスト + 画像の2カラム

```html
<div style="display: flex; gap: 1.5rem; margin-top: 1rem;">

<div style="flex: 1;">
  <!-- カード項目をここに並べる -->
</div>

<div style="flex-shrink: 0; display: flex; flex-direction: column; justify-content: center; gap: 1rem;">
  <img src="/image.png" style="width: 280px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);" />
</div>

</div>
```

### 画像の縦位置調整

```html
<!-- position: relative で微調整 -->
<img src="/image.png" style="...; position: relative; top: -20px;" />
```

### 番号付きステップ（丸数字）

```html
<div style="display: flex; align-items: center; gap: 0.8rem;">
  <div style="min-width: 2rem; height: 2rem; background: #4a6b8a; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.85rem;">1</div>
  <div>
    <div style="font-size: 1rem; font-weight: 600; color: #4a6b8a;">ステップタイトル</div>
    <div style="font-size: 0.8rem; color: #64748b;">説明テキスト</div>
  </div>
</div>
```

### 目次スライド

```html
# 目次

<div style="margin-top: 1rem;">

<div style="padding: 0.8rem 1.2rem; border-left: 4px solid #4a6b8a; margin-bottom: 0.8rem;">
  <div style="font-size: 1.2rem; font-weight: 600; color: #4a6b8a;">1. 項目タイトル</div>
</div>

<div style="padding: 0.8rem 1.2rem; border-left: 4px solid #7a6b8a; margin-bottom: 0.8rem;">
  <div style="font-size: 1.2rem; font-weight: 600; color: #7a6b8a;">2. 項目タイトル</div>
</div>

<div style="padding: 0.8rem 1.2rem; border-left: 4px solid #8a6b7a;">
  <div style="font-size: 1.2rem; font-weight: 600; color: #8a6b7a;">3. 項目タイトル</div>
</div>

</div>
```

### セクション区切り

```md
---
layout: section
---

# セクション名
```

### カラーパレット

| 用途 | カラー |
|------|--------|
| 1番目の項目 / h1 | `#4a6b8a` |
| 2番目の項目 | `#7a6b8a` |
| 3番目の項目 | `#8a6b7a` |
| 4番目の項目 / サブテキスト | `#64748b` |
| 警告 | `#dd6b20` |
| 危険 / NG | `#e53e3e` |
| グラデーション開始 | `#1e293b` |
| 著者名 / フッター | `#475569` |

### 項目数に応じたサイズ調整

| 項目数 | padding | margin-bottom | タイトル fontSize |
|--------|---------|---------------|-------------------|
| 2〜3   | 1.5rem  | 1.5〜2rem     | 1.3rem            |
| 4      | 1rem    | 0.8〜1rem     | 1.2rem            |
| 5以上  | 0.8rem  | 0.6〜0.8rem   | 1.1rem / 0.95rem  |

## ページ番号（global-bottom.vue）

各プロジェクトのルートに `global-bottom.vue` を配置すると、スライド右下にページ番号（`2 / 12` 形式）を表示できる。

- Slidev の仕様上、各プロジェクトごとに配置が必要
- 1枚目（表紙）では非表示

```vue
<template>
  <footer v-if="$slidev.nav.currentPage > 1" style="position: fixed; bottom: 8px; right: 16px; font-size: 0.75rem; color: #94a3b8; z-index: 100;">
    {{ $slidev.nav.currentPage }} / {{ $slidev.nav.total }}
  </footer>
</template>
```

## プレゼンターノート

各スライドの末尾に `<!-- -->` コメントでプレゼンターノートを書く。スライドの要点を箇条書きにする:

```md
<!--
- メインポイント1
- メインポイント2
- 補足説明
-->
```

## Tips

1. **画像は`public/`に配置** - `/images/foo.png`でアクセス可能
2. **開発中はホットリロード** - 保存で即座に反映
3. **PDFエクスポート** - `pnpm slidev export`
4. **プレゼンターモード** - URLに`/presenter`を追加
5. **概要モード** - `o`キーでスライド一覧
6. **カスタムスタイル** - `./styles/index.css`に記述で全体に適用
