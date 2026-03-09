# sunagaku-no-moto

入れるだけでスナガク味。

Slidev でスナガク流のプレゼンテーションを再現する Claude Code Plugin。

## Install

```bash
claude plugin add github:sean-sunagaku/sunagaku-no-moto
```

## 使い方

### 1. Clone してすぐ使う

```bash
git clone https://github.com/sean-sunagaku/sunagaku-no-moto.git
cd sunagaku-no-moto
./scripts/new-project.sh my_new_lt
cd my_new_lt
pnpm dev
```

### 2. Claude Code Plugin として使う

インストール後、Slidev スライドを作成・編集するときに自動でスナガク流のガイドラインが適用される。

```
# スライドを作って
/slidev

# プレゼンターノートを同期
/slidev-add-notes
```

## 含まれるもの

- **スナガク流デザインパターン**: グラデーションタイトル、border-left 3色カード、カラーパレット
- **共通テンプレート**: 自己紹介、ご清聴、ページ番号
- **固定アセット**: プロフィール写真、QRコード、アプリロゴ
- **自動化スクリプト**: 新規プロジェクト作成、共通画像同期

## License

MIT
