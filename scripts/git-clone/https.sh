#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
                -u|--username)
                username="$2"
                shift # past argument
                shift # past value
                ;;
                -p|--password)
                password="$2"
                shift # past argument
                shift # past value
                ;;
                -url|--url)
                url="$2"
                shift # past argument
                shift # past value
                ;;                
                -h|--help)
                help="true"
                shift
                ;;
                *)
                echo "Error! invalid flag: ${key}"
                help="true"
                break
                ;;
        esac
done

usage () {
        echo "USAGE: $0 [--host $host] [--src $source-file-path] [--target $target-file-path] [--user $userName] [--passwd $password]"
        echo "  [-u|--username ] the username of the git repo"
        echo "  [-p|--password ] the token of the git repo ."
        echo "  [-a|--address] the user name of the ssh remote login ."
        echo "  [-h|--help] Usage message"
}

if [[ $help ]]; then
        usage
        exit 0
fi
if [[ "$username" == "" || "$password" == "" || "$url" == "" ]]; then
    echo "username or password or url is blank ."
    exit 0
fi


set -e -x

/usr/bin/expect <<EOF

set timeout -1
spawn git clone $address

expect "Username*:"

send "$username\r"
expect "Password*:"

send "$password\r"

expect eof
EOF
