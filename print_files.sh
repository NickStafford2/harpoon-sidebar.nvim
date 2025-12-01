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

# Always ignore .git/
EXCLUDE_ARGS+=(-I ".git")

# Dump the directory tree for the *current* directory
tree "$TARGET_DIR" -a --noreport "${EXCLUDE_ARGS[@]}" >>"$OUTPUT" 2>/dev/null
echo "" >>"$OUTPUT"
