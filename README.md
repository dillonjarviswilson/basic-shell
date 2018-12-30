# basic-shell

basic-shell is a docker image which has the shellinabox tool installed https://github.com/shellinabox/shellinabox

Shell in a box is running on port 4200.
The Shellinabox parameters can be modified on lines 3-17 in the Dockerfile.

In addition, some basic tools have been installed: iproute2, apt-utils, net-tools, iputils-ping, nmap.

Additional software can be added at on line 34 in Dockerfile.

To build: $ docker build -t basic-shell .
