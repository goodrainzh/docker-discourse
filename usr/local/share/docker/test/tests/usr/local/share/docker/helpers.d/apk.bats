. /usr/local/share/docker/test/helpers
. /usr/local/share/docker/helpers
setup() {
  mkdir /test
  cd /test
}

teardown() {
  rm -rf /test
}

@test "#install_from_apk: choose the .apk over the .apt" {
  echo "libxslt1-dev" > .apt
  echo         "wget" > .apk
  run install_from_apk_file
  assert_true $status
}

# Tested through __sub_helpers_apk_convert_apt_dependencies_to_apk
@test "#install_from_apk: convert .apt dependencies" {
  echo 'libxslt1-dev' > .apt
  __sub_helpers_apk_convert_apt_dependencies_to_apk
  cat .apk | assert_string_contains libxslt-dev
}

@test "#install_from_apk: don't modify .apt if .apk exists" {
  echo 'libxslt1-dev' > .apt
  echo  'libxslt-dev' > .apk
  __sub_helpers_apk_convert_apt_dependencies_to_apk
  cat .apt | assert_string_contains libxslt1-dev
}
