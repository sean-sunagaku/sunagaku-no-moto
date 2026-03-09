# Slidev スタイリング・推奨CSS

## UnoCSS/Tailwind

UnoCSS（Tailwind互換）がデフォルトで利用可能。

### 基本的な使用

```html
<div class="text-xl font-bold text-blue-500">
  スタイル付きテキスト
</div>

<div class="grid grid-cols-2 gap-4">
  <div>左</div>
  <div>右</div>
</div>
```

### 属性化モード

```html
<div text="xl blue-500" font="bold">
  属性でスタイル指定
</div>
```

### スコープ付きCSS

```md
<style>
h1 {
  color: red;
}
</style>
```

### カスタムスタイル

`./styles/index.css` または `./style.css` に記述:

```css
:root {
  --slidev-theme-primary: #5d8392;
}

.slidev-layout h1 {
  color: var(--slidev-theme-primary);
}
```

### UnoCSS設定（uno.config.ts）

```ts
import { defineConfig } from 'unocss'

export default defineConfig({
  shortcuts: {
    'bg-main': 'bg-white text-[#181818] dark:(bg-[#121212] text-[#ddd])',
  },
})
```

## 推奨カスタムスタイル

`./styles/index.css` に以下を適用すると洗練されたデザインになる。

### フォント設定

```css
@import url('https://fonts.googleapis.com/css2?family=Zen+Kaku+Gothic+New:wght@400;500;700&display=swap');
```

- **Zen Kaku Gothic New** - 日本語プレゼンに最適（読みやすく統一感がある）

### CSS変数

```css
:root {
  /* Text Colors - 高コントラスト */
  --text-primary: #1e293b;
  --text-secondary: #475569;
  --text-muted: #64748b;

  /* Accent Colors */
  --accent-deep: #4a6b8a;
  --accent-rose: #8a6b7a;
  --accent-violet: #7a6b8a;
}
```

### 白背景ベーススタイル

```css
/* Base Layout - 白背景・フォント統一 */
.slidev-layout {
  font-family: 'Zen Kaku Gothic New', sans-serif !important;
  background: #ffffff !important;
  color: var(--text-primary);
  position: relative;
}

/* Typography - フォント統一 */
.slidev-layout h1 {
  font-family: 'Zen Kaku Gothic New', sans-serif;
  font-weight: 700;
  letter-spacing: 0;
  color: var(--text-primary);
  position: relative;
}

/* アンダーラインを消す（テーマのデフォルトで入る場合） */
.slidev-layout h1::after {
  display: none;
}

.slidev-layout h2,
.slidev-layout h3 {
  font-family: 'Zen Kaku Gothic New', sans-serif;
  font-weight: 500;
  color: var(--text-primary);
  letter-spacing: 0;
}

/* Body Text - 読みやすいサイズに */
.slidev-layout p,
.slidev-layout span,
.slidev-layout div {
  color: var(--text-primary);
  font-size: 1.75rem;
  line-height: 1.8;
}
```

### リストのフォントサイズ

```css
/* リスト - 大きめのサイズ（プレゼン向け） */
.slidev-layout li {
  font-size: 2rem;
  line-height: 1.8;
  margin-bottom: 0.6em;
}

/* ネストしたリスト - 少し小さめ */
.slidev-layout ul ul > li {
  font-size: 1.6rem;
  line-height: 1.7;
  margin-bottom: 0.4em;
}
```

### カスタムリストマーカー

```css
/* Lists - カスタムドット */
.slidev-layout ul {
  list-style: none;
  padding-left: 0;
}

.slidev-layout ul > li {
  position: relative;
  padding-left: 1.5em;
  margin-bottom: 0.5em;
}

/* ドットを文字の中央に揃える */
.slidev-layout ul > li::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0.9em;
  transform: translateY(-50%);
  width: 8px;
  height: 8px;
  background: linear-gradient(135deg, var(--accent-deep), var(--accent-violet));
  border-radius: 50%;
}

/* Nested lists */
.slidev-layout ul ul > li::before {
  top: 0.85em;
  transform: translateY(-50%);
  width: 6px;
  height: 6px;
  background: var(--accent-rose);
  opacity: 0.7;
}
```

### セクションタイトルのグラデーション

```css
/* Section Layout - 中央配置でグラデーションテキスト */
.slidev-layout.slidev-layout-section {
  background: #ffffff !important;
  display: flex;
  align-items: center;
  justify-content: center;
}

.slidev-layout.slidev-layout-section h1 {
  font-size: 3rem;
  text-align: center;
  background: linear-gradient(135deg, var(--accent-deep) 0%, var(--accent-violet) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* セクションタイトルのアンダーラインを消す */
.slidev-layout.slidev-layout-section h1::after {
  display: none;
}
```

### Center/Cover レイアウト

```css
/* Center Layout */
.slidev-layout.slidev-layout-center {
  background: #ffffff !important;
}

/* Cover/Default Layout */
.slidev-layout.slidev-layout-cover,
.slidev-layout.slidev-layout-default {
  background: #ffffff !important;
}

/* Two Cols Layout */
.slidev-layout.slidev-layout-two-cols {
  gap: 3rem;
}

/* 比較テキスト（不等号など） */
.text-2xl {
  font-family: 'Outfit', sans-serif;
  font-weight: 500;
  color: var(--text-primary) !important;
  letter-spacing: 0.05em;
}
```

### その他の調整

```css
/* Strong text */
.slidev-layout strong {
  color: var(--accent-deep);
  font-weight: 600;
}

/* Links */
.slidev-layout a {
  color: var(--accent-deep);
  text-decoration: none;
  border-bottom: 1px solid transparent;
  transition: border-color 0.2s ease;
}

.slidev-layout a:hover {
  border-bottom-color: var(--accent-deep);
}

/* Muted text - 見えるように調整 */
.opacity-50,
.opacity-70 {
  color: var(--text-muted) !important;
  opacity: 1 !important;
}

/* Smooth transitions for click animations */
.slidev-vclick-target {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Code blocks */
.slidev-code {
  background: rgba(255, 255, 255, 0.8) !important;
  border: 1px solid rgba(74, 107, 138, 0.1);
  border-radius: 8px;
}

/* Slide number styling */
.slidev-page-indicator {
  color: var(--text-muted);
  font-family: 'Outfit', sans-serif;
}
```

### テーマ上書きの注意点

Slidevのテーマスタイルを上書きするには `!important` が必要な場合がある:

```css
.slidev-layout {
  background: #ffffff !important;  /* テーマの背景を上書き */
}
```

## デザインのベストプラクティス

### フォントサイズ

プレゼンテーションでは読みやすさが重要。推奨サイズ:

- **リスト項目**: `2rem`（会場の後ろからでも読める）
- **ネストしたリスト**: `1.6rem`
- **本文テキスト**: `1.75rem`

### 色使い

- **背景は白**: 読みやすさとプロジェクター対応
- **テキスト**: 濃い色（`#1e293b`）で高コントラスト
- **アクセント**: 落ち着いた色（`#4a6b8a`, `#7a6b8a`）でグラデーション
- **強調**: `<strong>`タグでアクセントカラー適用

### レイアウトの選択

- **情報量が多い場合**: スライドを分割する（two-colsより別スライドの方が読みやすい）
- **セクション区切り**: `layout: section`でグラデーションタイトル
- **比較スライド**: 不等号（`>`）を使った比較は`text-2xl`クラスで強調
