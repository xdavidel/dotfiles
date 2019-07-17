#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile

# execute i3 window manager
exec awesome
