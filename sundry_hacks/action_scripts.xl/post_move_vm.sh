#!/bin/sh
basedir=$(dirname $0)
msg="POST MOVE action script run for VM: ${VMT_TARGET_NAME}" 
echo `date` "${msg}" >> /tmp/output_actionscript.out
${basedir}/slack.sh "${msg}"