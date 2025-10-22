#!/usr/bin/env bash

source <(./extract_env_from_state.sh)
cd set_up_replication && npm run exec
