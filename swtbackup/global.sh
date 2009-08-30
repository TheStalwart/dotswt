#!/bin/bash

LOGFILE=~/swtbackup-`date +%F_%H%M%S`.log
DIFFLOGFILE=/tmp/swtbackup.`whoami`.tmp.log

RSYNC_PARAMS="-vrltD --inplace --size-only --del --delete-excluded --progress"

