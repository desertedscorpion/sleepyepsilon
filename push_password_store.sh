#!/bin/bash

git -C "${@}" fetch origin master &&
git -C "${@}" rebase origin/master &&
git -C "${@}" push origin master
