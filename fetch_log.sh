#!/bin/bash

# fetches the last N lines of the production torquebox garbage collector log, pulls it down, and launches
# a GC log viewer

user=jeremyb
launch=0
path=${HOME}

function show_help {
    echo "usage: fetch_log <options>"
    echo " options"
    echo " -h,-?       : Show this help message"
    echo " -s server   : Connect to the named server"
    echo " -u user     : User to connect as"
    echo " -d path     : Download to named directory"
    echo " -l          : Launch GCViewer"
}

OPTIND=1
while getopts "h?s:u:d:l" opt; do
    case "$opt" in
        h|\?)
            show_help
            exit 0
            ;;
        s)
            server=$OPTARG
            ;;
        u)
            user=$OPTARG
            ;;
        d)
            path=$OPTARG
            ;;
	l)
	    launch=1
            ;;
    esac
done
shift $((OPTIND-1))

ssh ${user}@${server} 'tail -1000000 /opt/deploy/torquebox/torquebox-current/jboss/standalone/log/gc.log > ~/gc/torquebox-gc-log-$(date -d "today" +"%Y%m%d%H%M").log'
sleep 1
file=$(ssh ${user}@${server} "ls -lat ./gc/t* | awk -F ' ' '{ print \$NF }' | head -1") 
scp ${user}@${server}:${file} ${path}/${server}-torquebox-gc.log
if [ ${launch} -eq 1 ]; then
  java -jar /Users/jeremybotha/java/GCViewer-jb/target/gcviewer-1.35-SNAPSHOT.jar
fi
