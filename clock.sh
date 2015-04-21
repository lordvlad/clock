#!/bin/bash

function clock() {
    read -r -d '' USAGE <<EOF
clock task timer v0.0.1
usage: clock <command> [<task>] [-m <message>] [-f <clockfile>]

Track your working times using file system directories as
task identifiers.

commands:
  help    show this help
  in      clock in, will clock out any running task
  out     clock out
  log     show all log entries, or log entries for <task>
  list    show sums for all tasks

task:
  if no task is specified, the current working directory
  will be used as task specifier

options:
  -m|--message      record additional message when clocking in/out
  -f|--file         where to save the clocks, defaults to $HOME/.clocks
     --by-task      sort log entries by task for clock log

EOF

    # set defaults
    now=`date +%s`
    file="$HOME/.clock"
    command=""
    task=""
    message=""
    taskSet=false

    # parse command line parameters
    while [[ $# -gt 0 ]]
    do
        key="$1"
        case $key in
            --by-task)
                sortByTask=true
                shift
                ;;
            -m|--message)      # set clock in/out message
                message="$2"
                shift
                shift
                ;;
            -f|--file)         # set logfile location
                file="$2"
                shift
                shift
                ;;
            *)                 # set command or task
                if [[ -z $command ]]
                then
                    command="$1"
                    shift
                elif [[ -z $task ]]
                then
                    task=$(readlink -e "$1")
                    if [[ -z $task ]]
                    then
                        task="$1"
                    fi
                    taskSet=true
                    shift
                else
                    echo "Don't know what to do with the argument $1"
                    exit 1
                fi
                ;;
        esac
    done

    # default task is current working directory
    if [[ -z $task ]]
    then
        task=`pwd`
    fi

    function clockOut() {
        # find currently clocked in task
        if [[ -f $file ]]
        then
            cur=$(eval "tail -n1 $file | awk '\$2==\"in\" {print \$3}'")
            if [[ -n $cur ]]
            then
                echo -e "$now\tout\t$cur\t$message" >> $file
                echo "clocked out $cur"
            fi
        fi
    }

    function clockIn() {
        echo -e "$now\tin\t$task\t$message" >> $file
        echo "clocked in $task"
    }

    # clock in
    if [[ $command = "in" ]]
    then
        # first, try to clock out
        clockOut
        # now clock in
        clockIn
        exit 0
    fi

    # clock out
    if [[ $command = "out" ]]
    then
        clockOut $task
        exit 0
    fi

    # show log
    if [[ $command = "log" ]]
    then
        if [[ -f $file ]]
        then
            if [[ $taskSet = true ]]
            then
                tmp=${task//\//\\\/}
            else
                tmp=""
            fi

            # for every line that matches "out.*taskname", calculate the time spent on the task
            # in seconds, using the timestamp at clock-out ($1 on lines matching 'out.*' and the
            # timestamp at clock-in (a=$1 on each line). Then print the difference (s) in hh:mm:ss
            # format followed by the task name and message ($3 and $4)
            cmd="awk -F $'\t' '/out.*$tmp/{s=\$1-a; h=int(s/60/60); s=s-h*60*60; m=int(s/60); s=s-m*60; print strftime(\"%c\", a) \"\t\" sprintf(\"%02d\", h) \":\" sprintf(\"%02d\", m) \":\" sprintf(\"%02d\", s) \"\t\" \$3 FS \$4} {a=\$1}' $file"

            if [[ $sortByTask = true ]]
            then
                # because of the formatted time and date, the task is now in the 8th column
                cmd="$cmd | sort -k8"
                echo "$cmd"
            fi

            eval "$cmd"

        else
            echo "No tasks recorded yet"
        fi
        exit 0
    fi

    # show sums
    if [[ $command = "list" ]]
    then
        if [[ -f $file ]]
        then
            if [[ $taskSet = true ]]
            then
                tmp=${task//\//\\\/}
            else
                tmp=""
            fi

            cmd="awk -F $'\t' '/out.*$tmp/{s=\$1-a; print s FS \$3 FS \$4}{a=\$1}' $file"
            cmd="$cmd | sort -k2"
            cmd="$cmd | awk -F $'\t' 'BEGIN{s=0;a=0;b=\"\";c=\"\"}{if(b==\$2){s=s+\$1}else{h=int(s/60/60); s=s-h*60*60; m=int(s/60); s=s-m*60; print sprintf(\"%02d\", h) \":\" sprintf(\"%02d\", m) \":\" sprintf(\"%02d\", s) FS b FS c; s=\$1};a=\$1;b=\$2;c=\$3;}END{h=int(s/60/60); s=s-h*60*60; m=int(s/60); s=s-m*60; print sprintf(\"%02d\", h) \":\" sprintf(\"%02d\", m) \":\" sprintf(\"%02d\", s) FS b FS c}'"
            cmd="$cmd | tail -n+2"
            eval "$cmd"
        else
            echo "No tasks recorded yet"
        fi
        exit 0
    fi

    # show usage info
    echo "$USAGE"
    exit 0
}


if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f clock
else
  clock "${@}"
  exit 0
fi
