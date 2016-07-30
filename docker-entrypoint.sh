#!/bin/sh
user_context=
[ $# -gt 0 ] && user_context=true
[ "$DEBUG" ] && set -x
set -e

for f in /etc/startup1.d/*; do
  if [ -f "$f" ] && [ -x "$f" ]; then
    "$f" "$@"
  fi
done

stop_d() {
  if echo "$1" | grep -Eq '^[0-9]+$' && [ -d /etc/startup$1.d ] && [ "$(ls -A /etc/startup$1.d)" ]; then
    for f in /etc/startup$1.d/*; do
      sv stop "$f"
    done
  fi
}

shutdown_d() {
  if [ "$(ls -A /etc/shutdown.d)" ]; then
    for f in /etc/shutdown.d/*; do
      if [ -f "$f" ] && [ -x "$f" ]; then
        "$f"
      fi
    done
  fi
}

trap '{
  status=$?
  shutdown_d
  stop_d 3
  stop_d 2

  if [ "$wait_pid" ] && kill -0 $wait_pid
    then kill $wait_pid || true
  fi

  trap - EXIT
  #    128+2=INT              128+3=QUIT             128+15=TERM
  if [ $status -eq 130 ] || [ $status -eq 131 ] || [ $status -eq 143 ]; then
    status=0
  fi

  exit $status
}' EXIT QUIT TERM INT

runsvdir -P /etc/startup2.d &
runsvdir -P /etc/startup3.d &
wait_pid=$!

if [ "$user_context" ]; then
  touch /etc/user-context

  "$@"
  exit $?
else
  if [ -x /usr/bin/default ] || [ -x /usr/local/bin/default ]; then
    default &
    wait_pid=$!
  fi

  wait $wait_pid
  exit 0
fi
