# Yeelight Screen Bar Mac Controller

Yeelight LED スクリーンハンギングライトをMacのメニューバーから操作するためのツールです。

## 機能

メニューバーに表示されるアイコンから、以下の操作が可能です。

- ➕ **プラス**: 明るさを10上げます。
- ☕️ **チル**: 色温度を低くし、明るさを下げます。
- 🛑 **オフ**: 電源をオフにします。
- ✒️ **ノーマル**: 明るく、色温度を中間にします。
- ➖ **マイナス**: 明るさを10下げます。

## セットアップ

0. このリポジトリをクローンします。
   - `git clone https://github.com/ozawk/yeelight-screen-bar-mac-controller`
1. Yeelight公式アプリで「LANコントロール」を有効にします。
2. ライトのIPアドレスを確認します。
3. `config.txt`の1行目にライトのIPアドレスを設定します。
   - 2行目にポート番号を設定します。デフォルトは `55443` です。
   - 3行目にはスペーサーの幅が設定されています。
4. ./SwiftBar.appを起動し、Plugin Directoryとしてこのリポジトリの `./mac_menubar` フォルダを指定します。
5. 真ん中の電源マークを左クリックし、Ajust MenuBarよりMenuBarの左右調整をする。

