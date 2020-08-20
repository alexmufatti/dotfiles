#!/bin/sh


# Put the message, send to stdin, in a variable
message="$(cat -)"
# Look at the first argument,
# Use it to determine the account to use
# If not set, assume work
# All remaining arguments should be recipient addresses which should be passed to msmtp
case "$(echo "$1" | tr '[A-Z]' '[a-z]')" in
    "me") account="me"; shift ;;
    "run") account="run"; shift ;;
    *) account="me"; ;;
esac

cleanHeaders(){
    # In the headers, delete any lines starting with markdown
    cat - | sed '0,/^$/{/^markdown/Id;}'
}

echo "$message" | msmtp --account="$account" "$@"
