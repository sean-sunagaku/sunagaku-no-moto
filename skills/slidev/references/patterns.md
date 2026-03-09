# Slidev よく使うパターン・テンプレート

## タイトルスライド

### シンプルな例

```md
---
layout: cover
background: /images/cover.jpg
class: text-center
---

# プレゼンテーションタイトル

サブタイトル

<div class="abs-br m-6 text-sm opacity-50">
  発表者名 / 2024.01.01
</div>
```

### スタイリッシュな例（グラデーションテキスト + 色分けサブタイトル）

```md
---
theme: seriph
title: プレゼンテーションタイトル
class: text-center
---

<div class="relative z-10 h-full flex flex-col items-center justify-center" style="padding-top: 60px; padding-bottom: 60px;">

<div class="mb-2" style="font-size: 1.2rem; font-weight: 500; letter-spacing: 0.3em; color: #7a6b8a; text-transform: uppercase;">
Design Strategy
</div>

<div style="font-size: 4.5rem; font-weight: 800; line-height: 1.1; text-align: center; background: linear-gradient(135deg, #1e293b 0%, #4a6b8a 50%, #7a6b8a 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
メインタイトル<br>サブタイトル
</div>

<div class="mt-8 flex items-center gap-4" style="font-size: 1.5rem; font-weight: 600;">
  <span style="color: #4a6b8a;">項目1</span>
  <span style="color: #94a3b8;">vs</span>
  <span style="color: #7a6b8a;">項目2</span>
  <span style="color: #94a3b8;">vs</span>
  <span style="color: #8a6b7a;">項目3</span>
</div>

<div class="mt-12 text-center" style="display: flex; flex-flow: column; padding-top: 20px; padding-bottom: 20px; justify-content: center; align-items: center; gap: 0px; line-height: 76px;">
  <div style="font-size: 0.9rem; font-weight: 500; color: #64748b; letter-spacing: 0.05em;">
    イベント名
  </div>
  <div style="font-size: 1rem; font-weight: 500; color: #475569; margin-top: 0.2rem; height: 0px; line-height: 11px;">
    発表者名
  </div>
</div>

</div>
```

ポイント:
- **グラデーションテキスト**: `background: linear-gradient()` + `-webkit-background-clip: text` + `-webkit-text-fill-color: transparent`
- **小さいラベル**: 上部に英語ラベルで洗練された印象
- **色分けサブタイトル**: 各項目に異なるアクセントカラー
- **中央配置**: `flex flex-col items-center justify-center`
- **コンテナのパディング**: `padding-top: 60px; padding-bottom: 60px` で余白調整
- **フッター部分**: flexboxで縦並び、`gap: 0px` + `line-height` 調整で隙間を最小化

## 比較グリッドレイアウト

複数の比較項目を1枚のスライドにまとめる場合:

```md
# 比較軸まとめ

<div class="h-full flex items-center justify-center">
<div class="grid grid-cols-2 gap-12" style="width: 90%;">

<div style="padding: 1.5rem; border-left: 4px solid #4a6b8a;">
  <div style="font-size: 1.5rem; font-weight: 600; color: #4a6b8a; margin-bottom: 0.5rem;">項目1</div>
  <div style="font-size: 1.8rem; font-weight: 700;">A > B > C</div>
</div>

<div style="padding: 1.5rem; border-left: 4px solid #7a6b8a;">
  <div style="font-size: 1.5rem; font-weight: 600; color: #7a6b8a; margin-bottom: 0.5rem;">項目2</div>
  <div style="font-size: 1.8rem; font-weight: 700;">B > C > A</div>
</div>

<div style="padding: 1.5rem; border-left: 4px solid #8a6b7a;">
  <div style="font-size: 1.5rem; font-weight: 600; color: #8a6b7a; margin-bottom: 0.5rem;">項目3</div>
  <div style="font-size: 1.8rem; font-weight: 700;">C > A > B</div>
</div>

<div style="padding: 1.5rem; border-left: 4px solid #64748b;">
  <div style="font-size: 1.5rem; font-weight: 600; color: #64748b; margin-bottom: 0.5rem;">項目4</div>
  <div style="font-size: 1.8rem; font-weight: 700;">A > C > B</div>
</div>

</div>
</div>
```

ポイント:
- **2x2グリッド**: `grid grid-cols-2 gap-12` で2列レイアウト
- **幅90%**: `width: 90%` でスライド幅いっぱいに広げる
- **中央配置**: `h-full flex items-center justify-center` で縦横中央
- **色付きボーダー**: `border-left: 4px solid` で各項目を視覚的に区別
- **大きめフォント**: ラベル `1.5rem`、内容 `1.8rem` で見やすく

## セクション区切り

```md
---
layout: section
---

# セクション名
```

## 2カラムでコード説明

```md
---
layout: two-cols
---

# 説明

ここにコードの説明を書く

::right::

```ts
// コード例
const example = "code"
```
```

## 画像フルスクリーン

```md
---
layout: image
image: /path/to/image.png
---
```
