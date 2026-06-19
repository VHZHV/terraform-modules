#!/usr/bin/env bash
# wait_for.sh provides a helper to wait on background PIDs. Will fail after all completions after any error.
wait_for() {
  local jobs="${*:-$(jobs -p)}"
  local error=0

  for p in $jobs; do wait "$p" || error=1; done
  if [ $error != 0 ]; then exit 1; fi
}
