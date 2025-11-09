#!/bin/bash

# スクリプトのディレクトリに設定ファイルを保存
DIR=$(dirname "$0")
CONFIG_FILE="$DIR/../config.txt"

# 設定ファイルから幅を読み込む（なければデフォルト値20）
if [ -f "$CONFIG_FILE" ]; then
  config_lines=($(cat "$CONFIG_FILE" | grep -v '^#' | grep -v '^$'))
  if [ ${#config_lines[@]} -ge 3 ]; then
    WIDTH="${config_lines[2]}"
  else
    WIDTH=20
  fi
else
  WIDTH=20
fi

SVG_ICON_BASE64=$(echo -n "<svg width='${WIDTH}px' height='30px' viewBox='0 0 20 30' version='1.1' xmlns='http://www.w3.org/2000/svg'></svg>" | base64)
echo "| templateImage=$SVG_ICON_BASE64 bash='$0' param1=run terminal=false"
