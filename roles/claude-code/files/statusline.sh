#!/usr/bin/env bash

read -r data

model=$(echo "$data" | jq -r '.model.display_name // "unknown"')
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-repo")

echo "[$model] $branch"
