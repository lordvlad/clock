# clock

Track your working hours on the command line

# Install

Available as a [bpkg](http://www.bpkg.io/)
```sh
bpkg install [-g] lordvlad/clock
```

# Usage
```sh
clock <command> [<task>] [-m <message>] [-f <clockfile>] [-t <dir>]
```

commands:
  help    show the help
  in      clock in, will clock out any running task
  out     clock out
  log     show all log entries, or log entries for <task>
  list    show sums for all tasks

task:
  if no task is specified, the current working directory
  will be used as task specifier

options:
  -m --message      record additional message when clocking in/out
  -f --file         where to save the clocks, defaults to $HOME/.clocks
