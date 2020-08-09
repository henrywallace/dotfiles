#!/bin/bash

.init
exec i3
exec --no-startup-id picom -b
