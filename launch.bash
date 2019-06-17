#!/bin/bash

echo Running script \`./echo.bash $1 \'$2\'\` in socat
socat "exec:./echo.bash $1 '$2',sigint" udp-datagram:255.255.255.255:6666,bind=:6666,broadcast
