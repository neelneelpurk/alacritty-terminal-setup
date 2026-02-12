#!/usr/bin/env bash
# Detects the primary language/runtime version for the given directory.
# Usage: detect-lang-version.sh <directory>

dir="${1:-.}"

if [[ -f "$dir/Cargo.toml" ]]; then
  ver=$(rustc --version 2>/dev/null | awk '{print $2}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/go.mod" ]]; then
  ver=$(go version 2>/dev/null | awk '{print $3}' | sed 's/go//')
  echo "  ${ver:-?}"
elif [[ -f "$dir/package.json" ]]; then
  ver=$(node --version 2>/dev/null | sed 's/v//')
  echo "  ${ver:-?}"
elif [[ -f "$dir/requirements.txt" ]] || [[ -f "$dir/pyproject.toml" ]] || [[ -f "$dir/setup.py" ]] || [[ -f "$dir/Pipfile" ]]; then
  ver=$(python3 --version 2>/dev/null | awk '{print $2}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/pom.xml" ]] || [[ -f "$dir/build.gradle" ]] || [[ -f "$dir/build.gradle.kts" ]]; then
  ver=$(java -version 2>&1 | head -1 | awk -F'"' '{print $2}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/composer.json" ]]; then
  ver=$(php --version 2>/dev/null | head -1 | awk '{print $2}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/mix.exs" ]]; then
  ver=$(elixir --version 2>/dev/null | grep Elixir | awk '{print $2}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/stack.yaml" ]] || [[ -f "$dir/cabal.project" ]] || [[ -f "$dir/*.cabal" ]]; then
  ver=$(ghc --version 2>/dev/null | awk '{print $NF}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/build.sbt" ]]; then
  ver=$(scala -version 2>&1 | awk '{print $5}')
  echo "  ${ver:-?}"
elif [[ -f "$dir/build.zig" ]]; then
  ver=$(zig version 2>/dev/null)
  echo "  ${ver:-?}"
else
  echo ""
fi
