#!/bin/bash

set -e

TIMEOUT=30
APP_ROOT="/usr/local/nginx/rails-sample"

#RAILS_ENV=development
RAILS_ENV=production
PID=${APP_ROOT}/tmp/${RAILS_ENV}_unicorn.pid

CMD="bundle exec unicorn -D -c $APP_ROOT/config/unicorn.rb -E $RAILS_ENV"

action="$1"
set -u

old_pid="$PID.oldbin"

cd $APP_ROOT || exit 1

sig () {
    test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
    test -s $old_pid && kill -$1 `cat $old_pid`
}

case $action in
start)
    sig 0 && echo -e >&2 "\033[32mAlready running\033[m" && exit 0
    $CMD
    echo -e "\033[32mstarted\033[m"
    ;;
stop)
    sig QUIT && rm -f ${PID} && echo -e >&2 "\033[32mstoped\033[m"  && exit 0
    echo -e >&2 "\033[32mNot running\033[m"
    ;;
force-stop)
    sig TERM && echo -e >&2 "\033[32mforce-stoped\033[m" && exit 0
    echo -e >&2 "\033[32mNot running\033[m"
    ;;
restart|reload)
    sig HUP && echo -e "\033[32mreloaded OK\033[m" && exit 0
    echo -e >&2 "\033[31mCouldn't reload, starting '$CMD' instead\033[m"
    $CMD
    ;;
upgrade)
    if sig USR2 && sleep 2 && sig 0 && oldsig QUIT
    then
        n=$TIMEOUT
        while test -s $old_pid && test $n -ge 0
        do
            printf '.' && sleep 1 && n=$(( $n - 1 ))
        done
        echo

        if test $n -lt 0 && test -s $old_pid
        then
            echo >&2 "$old_pid still exists after $TIMEOUT seconds"
            exit 1
        fi
        exit 0
    fi
    echo >&2 "Couldn't upgrade, starting '$CMD' instead"
    $CMD
    ;;
reopen-logs)
    sig USR1
    ;;
*)

    echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
    exit 1
    ;;
esac
