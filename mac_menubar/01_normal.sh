#!/bin/bash

#icon指定
SVG_ICON_BASE64="PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDY0MCA2NDAiPjwhLS0hRm9udCBBd2Vzb21lIEZyZWUgNy4xLjAgYnkgQGZvbnRhd2Vzb21lIC0gaHR0cHM6Ly9mb250YXdlc29tZS5jb20gTGljZW5zZSAtIGh0dHBzOi8vZm9udGF3ZXNvbWUuY29tL2xpY2Vuc2UvZnJlZSBDb3B5cmlnaHQgMjAyNSBGb250aWNvbnMsIEluYy4tLT48cGF0aCBkPSJNNDMyLjUgODIuM0wzODIuNCAxMzIuNEw1MDcuNyAyNTcuN0w1NTcuOCAyMDcuNkM1NzkuNyAxODUuNyA1NzkuNyAxNTAuMyA1NTcuOCAxMjguNEw1MTEuNyA4Mi4zQzQ4OS44IDYwLjQgNDU0LjQgNjAuNCA0MzIuNSA4Mi4zek0zNDMuMyAxNjEuMkwzNDIuOCAxNjEuM0wxOTguNyAyMDQuNUMxNzguOCAyMTAuNSAxNjMgMjI1LjcgMTU2LjQgMjQ1LjVMNjcuOCA1MDkuOEM2NC45IDUxOC41IDY1LjkgNTI4IDcwLjMgNTM1LjhMMjI1LjcgMzgwLjRDMjI0LjYgMzc2LjQgMjI0LjEgMzcyLjMgMjI0LjEgMzY4QzIyNC4xIDM0MS41IDI0NS42IDMyMCAyNzIuMSAzMjBDMjk4LjYgMzIwIDMyMC4xIDM0MS41IDMyMC4xIDM2OEMzMjAuMSAzOTQuNSAyOTguNiA0MTYgMjcyLjEgNDE2QzI2Ny44IDQxNiAyNjMuNiA0MTUuNCAyNTkuNyA0MTQuNEwxMDQuMyA1NjkuN0MxMTIuMSA1NzQuMSAxMjEuNSA1NzUuMSAxMzAuMyA1NzIuMkwzOTQuNiA0ODMuNkM0MTQuMyA0NzcgNDI5LjYgNDYxLjIgNDM1LjYgNDQxLjNMNDc4LjggMjk3LjJMNDc4LjkgMjk2LjdMMzQzLjQgMTYxLjJ6Ii8+PC9zdmc+Cg=="
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

#onして、最大明るさ、真ん中色温度
if [ "$1" = "run" ]; then
  send_command '{"id":1,"method":"set_power","params":["on","smooth",500,1]}'
  sleep 0.1
  send_command '{"id":2,"method":"set_ct_abx","params":[4000,"smooth",500]}'
  sleep 0.1
  send_command '{"id":3,"method":"set_bright","params":[100,"smooth",500]}'
fi
