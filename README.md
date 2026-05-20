# Mockup Generator

スクリーンショットを差し替えるだけで、ノートPC・スマートフォンのモックアップ画像を生成するブラウザツールです。

**🔗 [公開ページ (GitHub Pages)](https://hoko-web.github.io/mockup-app/)**

すべての画像処理はブラウザ内で完結し、外部サーバーへは送信されません。

---

## 主な機能

- **3つの合成モード**
  - `PC + スマホ` — ノートPC とスマートフォンが並んだ合成画像
  - `PC のみ` — ノートPC 単体
  - `スマホ のみ` — スマートフォン単体
- **画面の位置微調整** — ±50% 範囲で X / Y を 1% 単位で調整可能
- **2種類の出力サイズ + カスタムサイズ**
  - 800 × 533 / 1200 × 800 / 任意の幅×高
- **透明 PNG 出力** — 任意の背景の上に重ねやすい
- **ファイル検証** — 非画像ファイル・30MB超のファイルは弾く

## プライバシー / セキュリティ

- **画像はすべてブラウザ内で処理** — `fetch` / `XHR` / `WebSocket` の実装ゼロ
- **Content Security Policy (CSP)** 適用 — `connect-src 'none'` で外部送信を物理的に禁止、 `frame-ancestors 'none'` でクリックジャッキング対策、 `object-src 'none'` / `base-uri 'none'` で DOM 改ざんを防御
- **第三者トラッキング・アナリティクスなし**
- **XSS sink ゼロ** — ユーザー入力を含む箇所はすべて `textContent` または DOM API で構築

## 使い方

1. [公開ページ](https://hoko-web.github.io/mockup-app/) を開く
2. 上部タブから合成モードを選択
3. スクリーンショットをスロットにドラッグ＆ドロップ or クリックして選択
4. 必要に応じて「画像の位置を微調整」で位置を調整
5. 出力サイズを選んで「PNG を保存」

## 技術スタック

- バニラ HTML / CSS / JavaScript（フレームワーク・npm 依存ゼロ）
- Canvas API でリアルタイム合成
- Flood-fill ベースの screen mask 検出 — Dynamic Island や自然な角丸も自動で除外

## ファイル構成

```
mockup-app/
├── assets/
│   ├── base.jpg            … PC + スマホの合成 base 画像
│   ├── laptop_only.jpg     … PC 単体の base 画像
│   └── phone_only.jpg      … スマホ単体の base 画像
├── mockup_generator.html   … 開発版（base 画像を外部から読み込む / 30KB）
├── index.html              … 配布版（base 画像を base64 で埋め込んだ単一ファイル / 3.5MB）
├── build.sh                … mockup_generator.html + assets/ の画像 → index.html を生成
├── LICENSE                 … MIT License
└── README.md
```

## ローカル開発

```bash
git clone https://github.com/Hoko-web/mockup-app.git
cd mockup-app
```

任意の HTTP サーバーで `mockup_generator.html` を開く:

```bash
# VS Code Live Server プラグイン / Python の組み込みサーバーなど
python3 -m http.server 5501
# → http://localhost:5501/mockup_generator.html
```

ファイル直接 (`file://`) ではブラウザの CORS 制約により動作しません。

### 配布用ファイルを再ビルド

```bash
./build.sh
# → index.html を再生成
```

`mockup_generator.html` か base 画像のいずれかを変更したときに実行します。

## ライセンス

- **コード**: [MIT License](./LICENSE)
- **画像素材** (`assets/base.jpg` / `assets/laptop_only.jpg` / `assets/phone_only.jpg`): 各素材の出所ライセンスに従ってください

## 作者

[Hoko](https://github.com/Hoko-web)
