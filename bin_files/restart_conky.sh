#!/bin/bash

killall conky

conky -c ~/.conkyrc_main &
exec conky -c ~/.conkyrc_remote.single_monitor
