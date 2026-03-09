# Slidev トラブルシューティング

## 1. h1 とコンテンツが重なる

**原因**: `height: XX%` の flex コンテナで縦中央寄せしつつ、h1 に `position: relative; top: -1.5rem` など上方向オフセットを設定すると、h1 がコンテンツ領域に食い込んで重なる。

```html
<!-- NG: h1 の位置とコンテンツが衝突する -->
<style>
h1 { position: relative; top: -1.5rem; }
</style>

<div style="display: flex; align-items: center; justify-content: center; height: 60%;">
  <div>コンテンツ</div>
</div>
```

**修正**: `height: XX%` の flex 中央寄せをやめ、`margin-top` で位置を調整する。h1 の `top` オフセットも削除。

```html
<!-- OK: margin-top でシンプルに配置 -->
<div style="margin-top: 2rem;">
  <div>コンテンツ</div>
</div>
```

**ポイント**: Slidev では h1 はスライド上部に自動配置される。コンテンツは `margin-top` で h1 との距離を調整するのが最も安定するパターン。

---

## 2. 存在しない画像を参照すると Vite エラーになる

**原因**: `<img src="/path/to/image.png">` で `public/` に存在しないファイルを参照すると、Vite のアセットインポート解析が失敗してスライド全体が表示されなくなる。

```
[vite] Internal server error: Failed to resolve import "/claude-md-example.png"
```

**修正**: 画像ファイルを `public/` に配置してから参照する。まだ画像がない場合はプレースホルダーテキストで代替する。

```html
<!-- 画像がまだない場合のプレースホルダー -->
<div style="padding: 1.5rem; background: #f8fafc; border-radius: 8px; text-align: center;">
  <div style="font-size: 0.9rem; color: #94a3b8;">※ スクリーンショットを public/ に配置</div>
</div>
```

**ポイント**: Slidev（Vite）は `<img src="/...">` を静的アセットとして解析するため、ファイルが存在しないとビルドエラーになる。HTML/CSS の `background-image: url()` でも同様。

---

## 3. 項目が多いスライドで下端にはみ出す

**原因**: 4〜5 項目あるスライドで、各項目の `padding` や `margin-bottom` が大きいとスライドの表示領域を超える。

**修正**: 項目数が多いスライドでは padding と margin を小さめにする。

```html
<!-- 3項目以下: ゆったり -->
<div style="padding: 1.5rem; border-left: 4px solid #4a6b8a; margin-bottom: 2rem;">

<!-- 4項目以上: コンパクトに -->
<div style="padding: 1rem; border-left: 4px solid #4a6b8a; margin-bottom: 0.8rem;">
```

**目安**:
| 項目数 | padding | margin-bottom | フォントサイズ |
|--------|---------|---------------|----------------|
| 2〜3   | 1.5rem  | 1.5〜2rem     | 1.3rem         |
| 4      | 1rem    | 0.8〜1rem     | 1.2rem         |
| 5以上  | 0.8rem  | 0.6〜0.8rem   | 1.1rem / 0.95rem |

---

## 4. 2カラムグリッドでテキストが不自然に折り返される

**原因**: `grid-cols-2`（50:50 分割）だと、日本語の長い文章が狭い幅で改行され、読みにくくなる。

```html
<!-- NG: 均等分割だとテキスト列が窮屈 -->
<div class="grid grid-cols-2 gap-6">
```

**修正**: `grid-template-columns` で比率を調整し、テキスト量が多い方に広いスペースを割り当てる。テキスト自体も短く書き直す。

```html
<!-- OK: テキスト列を広めに（3:2） -->
<div style="display: grid; grid-template-columns: 3fr 2fr; gap: 1.5rem;">
```

**ポイント**: 2カラムで片方が画像やプレースホルダーの場合、テキスト側を `3fr`、画像側を `2fr` にすると収まりが良い。テキストも「短く・端的に」書き直すとさらに安定する。

---

## 5. `npm run dev` の `--open` フラグでサーバーが即終了する

**原因**: 環境によっては `slidev --open` でブラウザを開く処理がエラーになり、dev サーバーごと終了する場合がある。

**修正**: `--open` を外して起動し、手動でブラウザを開く。

```bash
# NG: --open で落ちる場合がある
npm run dev  # "slidev --open"

# OK: --open を外す
npx slidev --port 3030
```

---

## まとめ: Slidev レイアウトの鉄則

1. **コンテンツの縦位置は `margin-top` で調整する**（`height: XX%` の flex 中央寄せは避ける）
2. **画像は必ず `public/` に配置してから参照する**
3. **項目数に応じて padding / margin / font-size を調整する**
4. **2カラムは `grid-cols-2` より `grid-template-columns` で比率指定する**
5. **h1 に `position: relative; top: ...` で上にずらすスタイルは使わない**
