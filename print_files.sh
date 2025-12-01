#!/bin/bash

# Use the current working directory
TARGET_DIR="$(pwd)"
OUTPUT="file_dump.txt"

###############################
# 1. Directory Structure
###############################
echo "=== CWD ===" >>"$OUTPUT"
echo "$TARGET_DIR" >>"$OUTPUT"
echo "" >>"$OUTPUT"

echo "=== Directory Tree ===" >>"$OUTPUT"

# Detect ignored files from git (optional)
IGNORES=$(git ls-files --others --exclude-standard --directory 2>/dev/null | sed 's|/$|/*|')

# Build exclusion args for tree
EXCLUDE_ARGS=()
for p in $IGNORES; do
  EXCLUDE_ARGS+=(-I "$p")
done

# Always ignore .git/ and .github/
EXCLUDE_ARGS+=(-I ".git")
EXCLUDE_ARGS+=(-I ".github")

# Dump the directory tree
tree "$TARGET_DIR" -a --noreport "${EXCLUDE_ARGS[@]}" >>"$OUTPUT" 2>/dev/null
echo "" >>"$OUTPUT"

#####################################
# 2. Dump specific source files
#####################################

dump_file() {
  local FILEPATH="$1"
  if [ -f "$FILEPATH" ]; then
    echo "=== FILE: $FILEPATH ===" >>"$OUTPUT"
    cat "$FILEPATH" >>"$OUTPUT"
    echo "" >>"$OUTPUT"
    echo "" >>"$OUTPUT"
  else
    echo "=== FILE NOT FOUND: $FILEPATH ===" >>"$OUTPUT"
    echo "" >>"$OUTPUT"
  fi
}

# Files to dump
dump_file "$TARGET_DIR/plugin/harpoon_sidebar.lua"
dump_file "$TARGET_DIR/lua/harpoon_sidebar/init.lua"
dump_file "$TARGET_DIR/lua/harpoon_sidebar/neotree.lua"
dump_file "$TARGET_DIR/lua/harpoon_sidebar/sidebar.lua"
