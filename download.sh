#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -e $DIR/config ]
then
    source $DIR/config
    wget -q --no-check-certificate --spider timeout=2 $BASELINK
    OUTPUT=$?
    echo "Server not accessible..." > $log_file
    if [ $OUTPUT -eq 0 ]
    then
        echo -e "Starting Download \n\n" > $log_file
        cd $local_dir
        for (( i = 0 ; i < ${#remote_dirs[@]} ; i++ )) do
            wget -nv -a $log_file -r -nH -N --no-parent --cut-dirs 2 --no-check-certificate --restrict-file-names=nocontrol --reject "index.html*" https://skripte.hsr.ch/${remote_dirs[$i]}
        done
    fi
else
    echo "ERROR: No config file founde at: ${DIR}/config"
fi
