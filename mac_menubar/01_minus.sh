#!/bin/bash
#1
#icon指定
SVG_ICON_BASE64="PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDY0MCA2NDAiPjwhLS0hRm9udCBBd2Vzb21lIEZyZWUgNy4xLjAgYnkgQGZvbnRhd2Vzb21lIC0gaHR0cHM6Ly9mb250YXdlc29tZS5jb20gTGljZW5zZSAtIGh0dHBzOi8vZm9udGF3ZXNvbWUuY29tL2xpY2Vuc2UvZnJlZSBDb3B5cmlnaHQgMjAyNSBGb250aWNvbnMsIEluYy4tLT48cGF0aCBkPSJNOTYgMzIwQzk2IDMwMi4zIDExMC4zIDI4OCAxMjggMjg4TDUxMiAyODhDNTI5LjcgMjg4IDU0NCAzMDIuMyA1NDQgMzIwQzU0NCAzMzcuNyA1MjkuNyAzNTIgNTEyIDM1MkwxMjggMzUyQzExMC4zIDM1MiA5NiAzMzcuNyA5NiAzMjB6Ii8+PC9zdmc+Cg=="
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

#現在明るさ取得し、-10して司令
if [ "$1" = "run" ]; then
  response=$(send_command '{"id":2,"method":"get_prop","params":["bright"]}')

  current_bright=$(echo "$response" | jq -r '.result[0]')
  new_bright=$((current_bright - 10))

  send_command "{\"id\":3,\"method\":\"set_bright\",\"params\":[$new_bright,\"smooth\",500]}"
fi
