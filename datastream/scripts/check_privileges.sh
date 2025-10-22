#!/bin/bash

echo "🔧 Setting up environment from Terraform state..."
source <(./extract_env_from_state.sh)

echo "🔍 Running DataStream privileges check..."
cd set_up_replication && npm run check