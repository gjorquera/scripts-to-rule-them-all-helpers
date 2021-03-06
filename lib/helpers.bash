#!/usr/bin/env bash

# Script Helpers
#
# A helper file that can sourced into your project scripts to to DRY them up.
# If you don't know what project scripts are, please read
# [scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all).
# More information: https://github.com/gjorquera/script-helpers

title() { echo -e "\033[0;34m\n${1}\n\033[0m"; }

ensure() {
  echo -n "$1... "
  if (exec &>/dev/null; eval $1); then
    echo -e "\033[0;32m✓ done\033[0m"
  else
    echo -e "\033[0;31m✗ error!$([ -z "$2" ] || echo "\nTry: $2")" && exit 1
  fi
}

cached() {
  [ -e "$1" ] || return 1
  local cache="$(cat ".cache.${1//\//_}" 2>/dev/null)"
  local new_cache=$(find "$1" -exec cat {} \; | shasum)
  echo "$new_cache" > ".cache.${1//\//_}" && [[ "$new_cache" == "$cache" ]]
}
