# clock

Track your working hours on the command line

# Install

Available as a [bpkg](http://www.bpkg.io/)
```sh
bpkg install [-g] lordvlad/clock
```

# Usage
```sh
clock <command> [<task>] [-m <message>] [-f <clockfile>]
```

## Commands
-  `clock help`    show the help
-  `clock in`      clock in, will clock out any running task
-  `clock out`     clock out
-  `clock log`     show all log entries, or log entries for `<task>`
-  `clock list`    show sums for all tasks

## Task
  If no task is specified, the current working directory
  will be used as task specifier

## Options
-  `-m|--message`      record additional message when clocking in/out
-  `-f|--file`         where to save the clocks, defaults to `$HOME/.clocks`
-  `   --by-task`      sort log entries by task for `clock log`
-  `    --gt=DATE`     show only log entries after DATE
                       summarize only entries after DATE for list view
                       DATE will take anything that works with unix' date command
- `     --lt=DATE`     show only log entries before DATE
                       summarize only entries before DATE for list view
                       DATE will take anything that works with unix' date command
