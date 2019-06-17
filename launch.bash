#!/bin/bash

socat "exec:./echo.bash Alice conversation.txt,sigint" udp-datagram:255.255.255.255:6666,bind=:6666,broadcast
