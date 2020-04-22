#!/bin/sh

# Script that sends a message to a slack channel via Slack webhook
# Will be a no-op if the SLACK_WEBHOOK environment variable is not set.
#
# USAGE:
#	slack.sh "My message to the slack channel"
#
# SCRIPT INPUTS
# - message: This is a quoted string of text to send to the slack channel.
#
# REQUIRED ENVIRONMENT VARIABLES
# - SLACK_WEBHOOK: this environment variable contains secret webhook code for the channel. It is obtained when you create the webhook.
# 


if [ ! -z ${SLACK_WEBHOOK} ]
then
	curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"Action Script Execution: ${1}\"}" https://hooks.slack.com/services/${SLACK_WEBHOOK}
fi
