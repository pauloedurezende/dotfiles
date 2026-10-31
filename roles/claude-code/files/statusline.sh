#!/usr/bin/env bash
#
# Claude Code statusline: model · bar pct% · $cost · branch
# Requires: jq, awk
#

read -r data

# Extract all fields in a single jq call (tab-separated)
IFS=$'\t' read -r model pct cost_raw cwd <<< "$(echo "$data" | jq -r '
  (.model | if type == "object" then .display_name
   else
     gsub("^(us\\.)?anthropic\\."; "")
     | gsub("\\[.*\\]$"; "")
     | gsub("-v[0-9]+.*$"; "")
     | gsub("-[0-9]{8}.*$"; "")
     | gsub("^claude-"; "")
     | if test("^[a-z]+-[0-9]+-[0-9]+")
       then capture("^(?<name>[a-z]+)-(?<maj>[0-9]+)-(?<min>[0-9]+)") |
            ((.name[:1] | ascii_upcase) + .name[1:]) + " " + .maj + "." + .min
       elif test("^[a-z]+-[0-9]+")
       then capture("^(?<name>[a-z]+)-(?<maj>[0-9]+)") |
            ((.name[:1] | ascii_upcase) + .name[1:]) + " " + .maj
       else ((.[:1] | ascii_upcase) + .[1:])
       end
   end // "unknown"
   | gsub("^Claude "; "")) as $model |
  ((.context_window.used_percentage // 0) | floor) as $pct |
  (.cost.total_cost_usd // 0) as $cost |
  (.cwd // ".") as $cwd |
  "\($model)\t\($pct)\t\($cost)\t\($cwd)"
')"

: "${model:=unknown}"
: "${pct:=0}"
: "${cost_raw:=0}"
: "${cwd:=.}"

# Granular progress bar — 20 chars, 1/8 precision
bar_w=20
partial=(" " "▏" "▎" "▍" "▌" "▋" "▊" "▉")

filled_steps=$(( pct * bar_w * 8 / 100 ))
full_chars=$(( filled_steps / 8 ))
partial_idx=$(( filled_steps % 8 ))
has_partial=0; (( partial_idx > 0 )) && has_partial=1
empty_chars=$(( bar_w - full_chars - has_partial ))

bar=""
for ((i=0; i<full_chars;  i++)); do bar+="█"; done
(( has_partial )) && bar+="${partial[$partial_idx]}"
for ((i=0; i<empty_chars; i++)); do bar+="░"; done

# Cost: $0.0034 if < $0.01, else $0.12
cost=$(awk "BEGIN { c=$cost_raw; printf (c < 0.01) ? \"\$%.4f\" : \"\$%.2f\", c }")

# Git branch (truncated at 25 chars)
branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-repo")
(( ${#branch} > 25 )) && branch="${branch:0:24}…"

printf " %s · %s %d%% · %s · %s\n" "$model" "$bar" "$pct" "$cost" "$branch"
