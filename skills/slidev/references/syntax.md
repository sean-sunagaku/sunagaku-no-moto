# Slidev マークダウン構文・レイアウト・アニメーション

## レイアウト

### 基本レイアウト
- `default` - 標準
- `center` - 中央配置
- `cover` - 表紙
- `intro` - イントロ
- `section` - セクション開始
- `quote` - 引用
- `end` - 終了ページ
- `full` - 全画面

### 分割レイアウト
- `two-cols` - 2列
- `two-cols-header` - ヘッダー付き2列
- `image-left` / `image-right` - 画像+テキスト
- `iframe-left` / `iframe-right` - iframe+テキスト

### 使用例

```md
---
layout: two-cols
---

# 左カラム

::right::

# 右カラム
```

```md
---
layout: image-right
image: /path/to/image.png
---

# テキスト内容
```

## コードブロック

### 基本

````md
```ts
const hello = "world"
```
````

### 行ハイライト

````md
```ts {2,3}
function add(
  a: number,  // ハイライトされる
  b: number   // ハイライトされる
) {
  return a + b
}
```
````

### 動的ハイライト（クリックで変化）

````md
```ts {2-3|5|all}
function add(
  a: number,
  b: number
) {
  return a + b
}
```
````

- `{2-3|5|all}`: 最初は2-3行目、クリックで5行目、さらにクリックで全体

### 特殊オプション
- `{hide}` - コードブロック非表示
- `{none}` - ハイライトなし

## アニメーション

### v-click（クリックで表示）

```md
<v-click>

クリックで表示される内容

</v-click>
```

ディレクティブ形式:
```html
<div v-click>クリックで表示</div>
```

### v-clicks（リスト全体に適用）

```md
<v-clicks>

- 項目1（1クリック目）
- 項目2（2クリック目）
- 項目3（3クリック目）

</v-clicks>
```

### v-after（前のv-clickと同時）

```html
<div v-click>Hello</div>
<div v-after>World</div>
```

### クリック順序指定

```html
<!-- 相対指定 -->
<div v-click="'+1'">前の要素から1クリック後</div>

<!-- 絶対指定 -->
<div v-click="3">3回目のクリックで表示</div>
```

### v-motion（モーションアニメーション）

```html
<div
  v-motion
  :initial="{ x: -80, opacity: 0 }"
  :enter="{ x: 0, opacity: 1 }"
  :leave="{ x: 80, opacity: 0 }"
>
  アニメーションする要素
</div>
```

クリックでトリガー:
```html
<div
  v-motion
  :initial="{ x: -100 }"
  :click-1="{ x: 0 }"
  :click-2="{ x: 100 }"
>
```

### アニメーションを使わない選択

LTや短いプレゼンでは、アニメーションを使わない方が良い場合もある:
- クリック操作の手間が省ける
- スライドの内容が一目で把握できる
- 発表のテンポが良くなる
- PDF出力時に全内容が表示される

削除する場合は `<v-click>`, `</v-click>`, `<v-clicks>`, `</v-clicks>` タグを削除するだけ。

## トランジション

```yaml
---
transition: slide-left
---
```

### ビルトイン
- `fade`
- `slide-left` / `slide-right`
- `slide-up` / `slide-down`
- `view-transition`

### 前後で異なるトランジション

```yaml
---
transition: slide-left | fade
---
```

## 組み込みコンポーネント

### Arrow（矢印）

```html
<Arrow x1="10" y1="20" x2="100" y2="200" />
<Arrow x1="10" y1="20" x2="100" y2="200" two-way />
```

### Link（スライドリンク）

```html
<Link to="5">5ページ目へ</Link>
```

### Toc（目次）

```html
<Toc />
```

特定スライドを目次から除外:
```yaml
---
hideInToc: true
---
```

### Transform（変形）

```html
<Transform :scale="1.5">
  拡大されるコンテンツ
</Transform>
```

### LightOrDark（テーマ別表示）

```html
<LightOrDark>
  <template #light>ライトモード用</template>
  <template #dark>ダークモード用</template>
</LightOrDark>
```

## プレゼンターノート

スライド末尾にHTMLコメントで記述:

```md
---

# スライドタイトル

内容

<!--
これはプレゼンターノートです。
発表者ビューでのみ表示されます。
-->
```
