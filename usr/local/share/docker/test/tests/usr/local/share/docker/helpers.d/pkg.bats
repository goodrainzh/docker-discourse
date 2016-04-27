. /usr/local/share/docker/test/helpers
. /usr/local/share/docker/helpers
setup() {
  mkdir /test
  cd /test
}

teardown() {
  rm -rf /test
}

@test "user_pkgs_installed: -> 0 if installed (apk)" {
  mkdir -p /etc/apk && touch /etc/apk/ran-user-install
  run user_pkgs_installed
  rm -f \
    /etc/apk/ran-user-install
  assert_true $status
}

@test "user_pkgs_installed: -> 1 if not installed (apk)" {
  run user_pkgs_installed
  assert_false $status
}

@test "user_pkgs_installed: -> 0 if installed (apt)" {
  mkdir -p /etc/apt && touch /etc/apt/ran-user-install
  run user_pkgs_installed
  rm -f \
    /etc/apt/ran-user-install
  assert_true $status
}

@test "user_pkgs_installed: -> 1 if not installed (apk)" {
  run user_pkgs_installed
  assert_false $status
}

@test "install_user_pkgs_from_file: it installs from .apt" {
  [ "$(operating_system)" != "ubuntu" ] && skip "Not Ubuntu"
  tmpdir=$(mktemp -d) && cd $tmpdir
  echo 'wget' > .apt

  install_user_pkgs_from_file
  run dpkg --get-selections
  apt-get autoremove \
    --purge -y wget
  rm -rf .apt

  echo $output | assert_string_contains \
    wget
}

@test "install_user_pkgs_from_file: it installs from .apk" {
  [ "$(operating_system)" != "alpine" ] && skip "Not Alpine"
  tmpdir=$(mktemp -d) && cd $tmpdir
  echo 'wget' > '.apk'

  install_user_pkgs_from_file
  run apk info
  apk --update del \
    wget
  rm -rf .apk

  echo $output | assert_string_contains \
    wget
}
