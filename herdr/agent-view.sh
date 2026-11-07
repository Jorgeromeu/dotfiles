#!/usr/bin/env bash
# Toggle herdr sidebar agent view: "focus" (current workspace + agents needing attention) <-> "all".
# Usage: agent-view.sh [focus|all|toggle]   (default: toggle)
# Each herdr server (local, or a named session on a remote) has its own socket and view.
sock="${HERDR_SOCKET_PATH:-$HOME/.config/herdr/herdr.sock}"
state="${XDG_STATE_HOME:-$HOME/.local/state}/herdr-agent-view-$(printf %s "$sock" | md5sum | cut -c1-8)"
mkdir -p "$(dirname "$state")"
mode="${1:-toggle}"
if [ "$mode" = toggle ]; then
  [ "$(cat "$state" 2>/dev/null)" = all ] && mode=focus || mode=all
fi
python3 -I - "$mode" "$sock" <<'PY'
import json, os, socket, sys
mode = sys.argv[1]
if mode == "all":
    req = {"method": "agent.view.clear", "params": {"source": "user"}}
else:
    req = {"method": "agent.view.set", "params": {
        "source": "user", "label": "focus",
        "filter": {"op": "any", "filters": [
            {"op": "eq", "field": "workspace_id", "value": {"context": "current_workspace_id"}},
            {"op": "in", "field": "status", "values": ["blocked", "done"]}]},
        "sort": [{"field": "attention"}, {"field": "workspace_order"}, {"field": "tab_order"}]}}
req["id"] = "agent-view"
s = socket.socket(socket.AF_UNIX)
s.connect(sys.argv[2])
s.sendall((json.dumps(req) + "\n").encode())
resp = json.loads(s.recv(65536).decode().splitlines()[0])
if "error" in resp:
    sys.exit(f"herdr: {resp['error']}")
PY
[ $? -eq 0 ] || exit 1
echo "$mode" > "$state"
