#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile

# execute window manager / desktop
exec awesome
