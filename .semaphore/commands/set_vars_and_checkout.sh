#!/usr/bin/env bash

export REPO_NAME='terraform-modules'
export MAIN_BRANCH='master'

export BRANCH_NAME="${SEMAPHORE_GIT_WORKING_BRANCH:-"${MAIN_BRANCH}"}"

(while ! checkout; do :; done) &
