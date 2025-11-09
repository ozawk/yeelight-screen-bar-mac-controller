#!/bin/bash

#icon指定
SVG_ICON_BASE64="PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDY0MCA2NDAiPjwhLS0hRm9udCBBd2Vzb21lIEZyZWUgNy4xLjAgYnkgQGZvbnRhd2Vzb21lIC0gaHR0cHM6Ly9mb250YXdlc29tZS5jb20gTGljZW5zZSAtIGh0dHBzOi8vZm9udGF3ZXNvbWUuY29tL2xpY2Vuc2UvZnJlZSBDb3B5cmlnaHQgMjAyNSBGb250aWNvbnMsIEluYy4tLT48cGF0aCBkPSJNMzUyIDY0QzM1MiA0Ni4zIDMzNy43IDMyIDMyMCAzMkMzMDIuMyAzMiAyODggNDYuMyAyODggNjRMMjg4IDMyMEMyODggMzM3LjcgMzAyLjMgMzUyIDMyMCAzNTJDMzM3LjcgMzUyIDM1MiAzMzcuNyAzNTIgMzIwTDM1MiA2NHpNMjEwLjMgMTYyLjRDMjI0LjggMTUyLjMgMjI4LjMgMTMyLjMgMjE4LjIgMTE3LjhDMjA4LjEgMTAzLjMgMTg4LjEgOTkuOCAxNzMuNiAxMDkuOUMxMDcuNCAxNTYuMSA2NCAyMzMgNjQgMzIwQzY0IDQ2MS40IDE3OC42IDU3NiAzMjAgNTc2QzQ2MS40IDU3NiA1NzYgNDYxLjQgNTc2IDMyMEM1NzYgMjMzIDUzMi42IDE1Ni4xIDQ2Ni4zIDEwOS45QzQ1MS44IDk5LjggNDMxLjkgMTAzLjMgNDIxLjcgMTE3LjhDNDExLjUgMTMyLjMgNDE1LjEgMTUyLjIgNDI5LjYgMTYyLjRDNDc5LjQgMTk3LjIgNTExLjkgMjU0LjggNTExLjkgMzIwQzUxMS45IDQyNiA0MjUuOSA1MTIgMzE5LjkgNTEyQzIxMy45IDUxMiAxMjggNDI2IDEyOCAzMjBDMTI4IDI1NC44IDE2MC41IDE5Ny4xIDIxMC4zIDE2Mi40eiIvPjwvc3ZnPgo="
echo "| templateImage=$SVG_ICON_BASE64 bash='$0' param1=run terminal=false"

#IP/ポート読み込み
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/../config.txt"
if [ -f "$CONFIG_FILE" ]; then
  config_lines=($(cat "$CONFIG_FILE" | grep -v '^#' | grep -v '^$'))

  #IPアドレス
  if [ ${#config_lines[@]} -ge 1 ]; then
    LIGHT_IP="${config_lines[0]}"
  fi

  #ポート番号
  if [ ${#config_lines[@]} -ge 2 ]; then
    LIGHT_PORT="${config_lines[1]}"
  fi
fi

send_command() {
  local cmd="$1"
  echo -e "${cmd}\r\n" | nc -w 1 "$LIGHT_IP" "$LIGHT_PORT" 2>/dev/null
}

#オフに
if [ "$1" = "run" ]; then
  send_command '{"id":1,"method":"set_power","params":["off","smooth",500]}'
fi
