#!/usr/bin/env sh

if command -v dwmblocks >/dev/null;
then
	killall dwmblocks
	dwmblocks &
else
	dwmbar &
fi
