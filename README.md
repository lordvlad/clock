# clock

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/e8397d6f1b8a4a8ca908604ece97fbf6)](https://www.codacy.com/gh/lordvlad/clock/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=lordvlad/clock&amp;utm_campaign=Badge_Grade)

Track your working hours on the command line

## Install

Available as a [bpkg](http://www.bpkg.io/) package.
```sh
bpkg install -g lordvlad/clock
``` 

Because getting sudo working can be a bitch:
```sh
sudo -E env "PATH=$PATH" bpkg install -g lordvlad/clock
```

## Usage
```sh
clock <command> [<task>] [<options>]
```

### Commands
- `clock help`         show the help
- `clock in`           clock in, will clock out any running task
- `clock out`          clock out
- `clock log`          show all log entries, or log entries for `<task>`
- `clock list`         show sums for all tasks
- `clock completion`   print the completion script

### Task
If no task is specified, the current working directory will be used as task specifier.

### Options
- `-m|--message`      record additional message when clocking in/out
- `-f|--file`         where to save the clocks, defaults to `$HOME/.clocks`
- `   --by-task`      sort log entries by task for `clock log`
- `   --gt=DATE`      with `clock log`, show only entries after `DATE`, with `clock list` sum up only entries after `DATE`.
                      `DATE` can be any string that unix' `date` understands
- `    --lt=DATE`     with `clock log`, show only entries before `DATE`, with `clock list` sum up only entries before `DATE`.
                      `DATE` can be any string that unix' `date` understands


## Examples

```sh
$ mkdir -p tasks/{work,sleep}
$ clock in tasks/work
> clocked in /home/lordvlad/tasks/work
$ clock in tasks/sleep
> clocked out /home/lordvlad/tasks/work
> clocked in /home/lordvlad/tasks/sleep
$ clock out
> clocked out /home/lordvlad/tasks/sleep
$ clock log
> Tue 21 Apr 2015 06:31:24 PM UTC 00:01:23        /home/lordvlad/tasks/work
> Tue 21 Apr 2015 06:32:47 PM UTC 00:00:04        /home/lordvlad/tasks/sleep
$ clock list
> 00:00:04        /home/lordvlad/tasks/sleep
> 00:01:23        /home/lordvlad/tasks/work
```

