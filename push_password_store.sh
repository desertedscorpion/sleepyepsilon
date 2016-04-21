#!/bin/bash

pass git -C fetch origin master &&
pass git -C rebase origin/master &&
pass git -C push origin master
