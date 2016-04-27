. /usr/local/share/docker/test/helpers
. /usr/local/share/docker/helpers

setup() {
  tmpdir=$(mktemp -d)
}

teardown() {
  delgroup test1 1>/dev/null 2>&1 || true
  delgroup test2 1>/dev/null 2>&1 || true
  deluser  test1 1>/dev/null 2>&1 || true
  deluser  test2 1>/dev/null 2>&1 || true

  # Remove all the files we use here instead of doing it in the test,
  # this way we can keep our tests clean and short and to the point of what
  # they are testing, rather than muddling your view of them.

  rm -rf $tmpdir 2>/dev/null || true
  rm -rf /var/log/test.log 2>/dev/null || true
  rm -rf /etc/startup2.d/stdout 2>/dev/null || true
  rm -rf /var/log/test/test.log 2>/dev/null || true
  rm -rf /var/log/test 2>/dev/null || true
  rm -rf /test.txt 2>/dev/null || true
  rm -rf /test 2>/dev/null || true
}

@test "#operating_system: output operating system" {
  run operating_system
  assert_eq "$output" ubuntu || assert_eq "$output" alpine
}

@test "#cleanup: ! *.apk-new" {
  touch $tmpdir/test.apk-new
  run cleanup $tmpdir
  refute_file $tmpdir/test.apk-new
}

@test "#cleanup: ! *.dpkg-dist" {
  touch $tmpdir/test.dpkg-dist
  run cleanup $tmpdir
  refute_file $tmpdir/test.dpkg-dist
}

@test "#enable_stdout_logger: cp /usr/share/docker/startup2.d/stdout -> /etc/startup2.d/stdout" {
  mkdir -p /etc/startup2.d
  enable_stdout_logger
  assert_file /etc/startup2.d/stdout/run
}

@test "#test_sha -> 1" {
  touch /test.txt
  run test_sha /test.txt abc
  assert_false $status
  assert_eq "$output" "Bad Download!"
}

@test "#create_log: create dir, file, chown" {
  run create_log daemon:daemon test/test.log
  assert_dir /var/log/test
  assert_file /var/log/test/test.log
  assert_user_owner  /var/log/test/test.log daemon
  assert_group_owner /var/log/test/test.log daemon
  assert_group_owner /var/log/test daemon
  assert_user_owner  /var/log/test daemon
}

@test "#create_dir: create dir, chown, chmod" {
  run create_dir daemon:daemon /test og-rwx
  assert_true $status
  assert_user_owner  /test daemon
  assert_group_owner /test daemon
  assert_permissions /test drwx------
}

@test "#reset_users: modify the uid" {
  addgroup test1 -g 601 || addgroup --gid 601 test1
  adduser -DG test1 -u 601 test1 || adduser \
    --system --gid 601 --uid 601 test1

  reset_users test1:701
  run sh -c "getent passwd test1 | awk -F: '{ print \$3 }'"
  assert_eq "$output" 701
}

@test "#reset_users: modify the gid" {
  addgroup test1 -g 601 || addgroup --gid 601 test1
  adduser -DG test1 -u 601 test1 || adduser \
    --system --gid 601 --uid 601 test1

  reset_users test1:701
  result1="$(getent  group test1 | awk -F: '{ print $3 }')"
  result2="$(getent passwd test1 | awk -F: '{ print $4 }')"
  assert_eq "$result1" 701
  assert_eq "$result2" 701
}

@test "#reset_users: leave group if not eq" {
  addgroup test1 -g 601 || addgroup test1 --gid 601
  addgroup test2 -g 602 || addgroup test2 --gid 602
  adduser -DG test2 -u 601 test1 || adduser \
    --system --system --gid 602 --uid 601 test1

  reset_users test1:701
  run sh -c "getent passwd test1 | awk -F: '{ print \$4 }'"
  assert_eq "$output" 602
}

@test "#reset_users: change old uid on files" {
  addgroup test1 -g 601 || addgroup --gid 601 test1
  adduser -DG test1 -u 601 test1 || adduser \
    --system --gid 601 --uid 601 test1

  touch /test.txt
  chown nobody:test1 /test.txt
  reset_users test1:602
  run test "$(stat -c %g /test.txt)" == "602"
  assert_true $status
}

@test "#reset_users: search for files owned by the user and replace" {
  addgroup test1 -g 601 || addgroup --gid 601 test1
  adduser -DG test1 -u 601 test1 || adduser \
    --system --gid 601 --uid 601 test1

  touch /test.txt
  chown test1:test1 /test.txt
  reset_users test1:602
  run test "$(stat -c %u /test.txt)" == "602"
  assert_true $status
}

@test "#get_file_uid: it returns the UID" {
  touch /test.txt && chown 1001:1001 /test.txt
  run get_file_uid /test.txt
  assert_eq "$output" \
    1001
}
