. /usr/local/share/docker/test/helpers
@test "set \$HOME" {
  bin=$(PATH=$(echo $PATH | sed -r 's,/usr/local/(s)?bin:,,g') \
    which chpst)

  [ ! -z "$bin" ] || pending "No chpst."
  assert_eq "$(chpst -u bin sh -c 'echo $HOME')" "/bin"
}
