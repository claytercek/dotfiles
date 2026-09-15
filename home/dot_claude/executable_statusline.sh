#!/usr/bin/env bash
# Claude Code status line.
# Input: JSON on stdin (https://code.claude.com/docs/en/statusline)
#
#   Fable 5.1 · high  │  ctx 42%  │  main*  │  5h 23% · 7d 41%     (subscription)
#   Fable 5.1 · high  │  ctx 42%  │  main*  │  $1.23               (API billing)

input=$(cat)

if ! command -v jq >/dev/null 2>&1; then
  printf 'statusline: jq missing'
  exit 0
fi

# Tab-separated so names with spaces survive. "-" marks a missing value.
IFS=$'\t' read -r model effort ctx cwd cost five seven < <(printf '%s' "$input" | jq -r '
  [
    (.model.display_name // "Claude"),
    (.effort.level // "-"),
    (.context_window.used_percentage // "-"),
    (.workspace.current_dir // .cwd // "-"),
    (.cost.total_cost_usd // "-"),
    (.rate_limits.five_hour.used_percentage // "-"),
    (.rate_limits.seven_day.used_percentage // "-")
  ] | @tsv')

dim=$'\e[2m'; bold=$'\e[1m'; green=$'\e[32m'; yellow=$'\e[33m'; red=$'\e[31m'; reset=$'\e[0m'
sep=" ${dim}│${reset} "

pct_color() {
  local p=${1%.*}
  if [ "$p" -ge 80 ]; then printf '%s' "$red"
  elif [ "$p" -ge 50 ]; then printf '%s' "$yellow"
  else printf '%s' "$green"; fi
}

segs=()

# model · effort
m="${bold}${model}${reset}"
[ "$effort" != "-" ] && m="$m ${dim}·${reset} $effort"
segs+=("$m")

# context usage
[ "$ctx" != "-" ] && segs+=("ctx $(pct_color "$ctx")${ctx%.*}%${reset}")

# git branch, dirty marker
if [ "$cwd" != "-" ] && branch=$(git -C "$cwd" branch --show-current 2>/dev/null) && [ -n "$branch" ]; then
  dirty=""
  [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null | head -1)" ] && dirty="${yellow}*${reset}"
  segs+=("${branch}${dirty}")
fi

# subscription limits if present, else API spend
if [ "$five" != "-" ] || [ "$seven" != "-" ]; then
  lim=()
  [ "$five" != "-" ] && lim+=("5h $(pct_color "$five")${five%.*}%${reset}")
  [ "$seven" != "-" ] && lim+=("7d $(pct_color "$seven")${seven%.*}%${reset}")
  segs+=("$(IFS=; printf '%s' "${lim[0]}"; [ ${#lim[@]} -gt 1 ] && printf ' %s·%s %s' "$dim" "$reset" "${lim[1]}")")
elif [ "$cost" != "-" ]; then
  segs+=("$(printf '$%.2f' "$cost")")
fi

out=""
for s in "${segs[@]}"; do
  [ -n "$out" ] && out="$out$sep"
  out="$out$s"
done
printf '%s' "$out"
