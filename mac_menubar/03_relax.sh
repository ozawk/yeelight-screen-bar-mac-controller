#!/bin/bash

#icon指定
SVG_ICON_BASE64="PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDY0MCA2NDAiPjwhLS0hRm9udCBBd2Vzb21lIEZyZWUgNy4xLjAgYnkgQGZvbnRhd2Vzb21lIC0gaHR0cHM6Ly9mb250YXdlc29tZS5jb20gTGljZW5zZSAtIGh0dHBzOi8vZm9udGF3ZXNvbWUuY29tL2xpY2Vuc2UvZnJlZSBDb3B5cmlnaHQgMjAyNSBGb250aWNvbnMsIEluYy4tLT48cGF0aCBkPSJNMTg0IDQ4QzE3MC43IDQ4IDE2MCA1OC43IDE2MCA3MkMxNjAgMTEwLjkgMTgzLjQgMTMxLjQgMTk5LjEgMTQ1LjFMMjAwLjIgMTQ2LjFDMjE2LjUgMTYwLjQgMjI0IDE2Ny45IDIyNCAxODRDMjI0IDE5Ny4zIDIzNC43IDIwOCAyNDggMjA4QzI2MS4zIDIwOCAyNzIgMTk3LjMgMjcyIDE4NEMyNzIgMTQ1LjEgMjQ4LjYgMTI0LjYgMjMyLjkgMTEwLjlMMjMxLjggMTA5LjlDMjE1LjUgOTUuNyAyMDggODguMSAyMDggNzJDMjA4IDU4LjcgMTk3LjMgNDggMTg0IDQ4ek0xMjggMjU2QzExMC4zIDI1NiA5NiAyNzAuMyA5NiAyODhMOTYgNDgwQzk2IDUzMyAxMzkgNTc2IDE5MiA1NzZMMzg0IDU3NkM0MjUuOCA1NzYgNDYxLjQgNTQ5LjMgNDc0LjUgNTEyTDQ4MCA1MTJDNTUwLjcgNTEyIDYwOCA0NTQuNyA2MDggMzg0QzYwOCAzMTMuMyA1NTAuNyAyNTYgNDgwIDI1NkwxMjggMjU2ek00ODAgNDQ4TDQ4MCAzMjBDNTE1LjMgMzIwIDU0NCAzNDguNyA1NDQgMzg0QzU0NCA0MTkuMyA1MTUuMyA0NDggNDgwIDQ0OHpNMzIwIDcyQzMyMCA1OC43IDMwOS4zIDQ4IDI5NiA0OEMyODIuNyA0OCAyNzIgNTguNyAyNzIgNzJDMjcyIDExMC45IDI5NS40IDEzMS40IDMxMS4xIDE0NS4xTDMxMi4yIDE0Ni4xQzMyOC41IDE2MC40IDMzNiAxNjcuOSAzMzYgMTg0QzMzNiAxOTcuMyAzNDYuNyAyMDggMzYwIDIwOEMzNzMuMyAyMDggMzg0IDE5Ny4zIDM4NCAxODRDMzg0IDE0NS4xIDM2MC42IDEyNC42IDM0NC45IDExMC45TDM0My44IDEwOS45QzMyNy41IDk1LjcgMzIwIDg4LjEgMzIwIDcyeiIvPjwvc3ZnPgo="
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

#onして、最小明るさ、最小色温度
if [ "$1" = "run" ]; then
  send_command '{"id":1,"method":"set_power","params":["on","smooth",500,1]}'
  sleep 0.1
  send_command '{"id":2,"method":"set_ct_abx","params":[2700,"smooth",500]}'
  sleep 0.1
  send_command '{"id":3,"method":"set_bright","params":[10,"smooth",500]}'
fi
