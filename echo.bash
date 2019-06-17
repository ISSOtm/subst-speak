#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage:    $0 sender_nick conv_file" >&2
    exit 1
fi

SENDER_NICK="$1"
true {CONV_FD}<"$2" # Open file to read it line by line


# Cipher is a simple substitution cipher, implemented with `tr`
KEY=$(cat ./key | tr '[a-z]' '[A-Z]')$(cat ./key | tr '[A-Z]' '[a-z]')
encode() {
    tr '[A-Za-z]' " $KEY"
}
decode() {
    tr "$KEY" "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
}


end_conversation() {
    echo "SIGINT recieved, stopping." >&2
    echo \<$SENDER_NICK\> Au revoir ! | encode
    true {CONV_FD}<&- # Close conversation file's descriptor
    exit 0
}
trap end_conversation INT


# Begin conversation to trigger other end if it's connected
echo \<$SENDER_NICK\> Salutations ! | encode

while read RECV_MSG; do
    # We've just recieved a message, but first decrypt it
    MSG=$(echo $RECV_MSG | decode)
    # Print what we've recieved to the output terminal
    echo $MSG >&2

    # We recieve messages from everyone, including ourselves; don't respond to ourselves, that would be pretty silly
    # Assume the message is formatted as such: "<Nickname> Content"
    MSG_AUTHOR=$(echo $MSG | cut -d '<' -f 2- -s | cut -d '>' -f 1 -s)
    if [ "$MSG_AUTHOR" != "$SENDER_NICK" ]; then
        # If we recieved a message from someone else, delay a bit to pretend typing up the message
        sleep 8s
        echo \<$SENDER_NICK\> $(head -n 1 <&$CONV_FD) | encode
    fi
done
