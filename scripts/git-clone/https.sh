#!/bin/bash
set -e -x
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
                -a|--url)
                url="$2"
                shift # past argument
                shift # past value
                ;;                
                -d|--dir)
                localDir="$2"
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
        echo "  [-a|--url] the address of the git repo that can't be blank ."
        echo "  [-d|--dir] the location of the download ."
        echo "  [-h|--help] Usage message"
}
localDir=${localDir:-"/data"}
function publicRepo(){
  git clone $url $localDir
}

function privateRepo(){
/usr/bin/expect <<EOF
set timeout -1
spawn git clone $url  $localDir

expect "Username*:"

send "$username\r"
expect "Password*:"

send "$password\r"

expect eof
EOF

}

if [[ $help ]]; then
        usage
        exit 0
fi
if [[   "$url" == "" ]]; then
    echo " url is blank ."
    exit 0
fi

if [[ "$username" == "" || "$password" == "" ]]; then
    echo "down public repo : $url ."
    publicRepo
    echo "Finished."
else
     echo "down private repo : $url ."
     if [ "$(ls -A $localDir)" ]; then
        echo "$localDir is not Empty"
        exit 0
     else
       privateRepo
     fi
     echo "Finished."
fi
