. /usr/local/share/docker/test/helpers
. /usr/local/share/docker/helpers
default_dir=vendor/bundle
default_file=Gemfile

teardown() {
  rm -rf /usr/share/ruby
  rm -rf /usr/share/ruby/default-gems
  rm -rf /test

  rm -rf /usr/lib/ruby/gems/2.2.0/specifications/*.gemspec
  rm -rf /usr/lib/ruby/gems/2.2.0/gems/*
}

setup() {
  mkdir -p /test/vendor
  cd /test
}

@test "#add_gemfile_dependency: gem" {
  add_gemfile_dependency feralchimp
  assert_match 'gem "feralchimp"'
}

@test "#add_gemfile_dependency: gem@version" {
  add_gemfile_dependency feralchimp@1.1.0
  assert_match 'gem "feralchimp", "1.1.0"'
}

@test "#add_gemfile_dependency: gem,user/repo" {
  add_gemfile_dependency feralchimp,envygeeks/feralchimp
  assert_match 'gem "feralchimp", :github => "envygeeks/feralchimp"'
}

@test "#add_gemfile_dependency: gem@version,user/repo" {
  add_gemfile_dependency feralchimp@1.1.0,envygeeks/feralchimp
  assert_match 'gem "feralchimp", "1.1.0", :github => "envygeeks/feralchimp"'
}

@test "#add_gemfile_dependency: gem@version,user/repo@branch" {
  add_gemfile_dependency feralchimp@1.1.0,envygeeks/feralchimp@master
  match='gem "feralchimp", "1.1.0", :github =>'
  match=$match' "envygeeks/feralchimp", :branch => "master"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem,user/repo@branch" {
  add_gemfile_dependency feralchimp,envygeeks/feralchimp@master
  match='gem "feralchimp", :github =>'
  match=$match' "envygeeks/feralchimp", :branch => "master"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem,git://fqdn:user/repo.git" {
  add_gemfile_dependency feralchimp,git://github.com:envygeeks/feralchimp.git
  match='gem "feralchimp", :git =>'
  match=$match' "git://github.com:envygeeks/feralchimp.git"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem@version,git://fqdn:user/repo.git" {
  add_gemfile_dependency feralchimp@1.1.0,git://github.com:envygeeks/feralchimp.git
  match='gem "feralchimp", "1.1.0", :git =>'
  match=$match' "git://github.com:envygeeks/feralchimp.git"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem@version,git://fqdn:user/repo.git@branch" {
  add_gemfile_dependency feralchimp@1.1.0,git://github.com:envygeeks/feralchimp.git@master
  match='gem "feralchimp", "1.1.0", :git => "git://github.com:'
  match=$match'envygeeks/feralchimp.git", :branch => "master"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem,git://fqdn:user/repo.git@branch" {
  add_gemfile_dependency feralchimp,git://github.com:envygeeks/feralchimp.git@master
  match='gem "feralchimp", :git => "git://github.com:'
  match=$match'envygeeks/feralchimp.git", :branch => "master"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem,https://fqdn/user/repo.git" {
  add_gemfile_dependency feralchimp,https://github.com/envygeeks/feralchimp.git
  match='gem "feralchimp", :git =>'
  match=$match' "https://github.com/envygeeks/feralchimp.git"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem@version,https://fqdn/user/repo.git" {
  add_gemfile_dependency feralchimp@1.1.0,https://github.com/envygeeks/feralchimp.git
  match='gem "feralchimp", "1.1.0", :git =>'
  match=$match' "https://github.com/envygeeks/feralchimp.git"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem@version,https://fqdn/user/repo.git@branch" {
  add_gemfile_dependency feralchimp@1.1.0,https://github.com/envygeeks/feralchimp.git@master
  match='gem "feralchimp", "1.1.0", :git => "https://github.com/'
  match=$match'envygeeks/feralchimp.git", :branch => "master"'
  assert_match "$match"
}

@test "#add_gemfile_dependency: gem,https://fqdn/user/repo.git@branch" {
  add_gemfile_dependency feralchimp,https://github.com/envygeeks/feralchimp.git@master
  match='gem "feralchimp", :git => "https://github.com/'
  match=$match'envygeeks/feralchimp.git", :branch => "master"'
  assert_match "$match"
}

@test "#has_previous_gemfile -> 1 if ! Gemfile.old" {
  run has_previous_gemfile
  assert_false $status
}

@test "#has_previous_gemfile -> 0 if Gemfile.old.*" {
  touch vendor/Gemfile.old.$(date +%m%d%Y)
  run has_previous_gemfile
  assert_true $status
}

@test "#backup_gemfile: cp to vendor/Gemfile.old.*" {
  touch Gemfile && backup_gemfile
  assert_file vendor/Gemfile.old.$(date +%m%d%Y)
}

@test "#copy_default_gems_to_gemfile -> cp to Gemfile" {
  mkdir -p /usr/share/ruby && touch /usr/share/ruby/default-gems
  echo 'source "https://rubygems.org"' > Gemfile
  echo "feralchimp@1.1.0" > /usr/share/ruby/default-gems
  echo "clippy" >> /usr/share/ruby/default-gems
  copy_default_gems_to_gemfile
  assert_also_contains feralchimp 1.1.0
  assert_contains clippy
}

@test "#install_default_gems -> 0" {
  mkdir -p /usr/share/ruby
  echo 'feralchimp@1.1.0' > /usr/share/ruby/default-gems
  echo 'clippy' >> /usr/share/ruby/default-gems
  install_default_gems
  assert_true $?
  gem list | assert_string_contains clippy
  gem list | assert_string_also_contains feralchimp 1.1.0
}

@test "#install_users_gems -> 0" {
  echo 'source "https://rubygems.org"' > Gemfile
  echo 'gem "feralchimp"' >> Gemfile
  gem install bundler
  install_users_gems
  assert_true $?
  gem list | assert_string_contains feralchimp
}

@test "#install_users_gems -> 0 w/ git" {
  echo 'source "https://rubygems.org"' > Gemfile
  echo 'gem "feralchimp", :github => "envygeeks/feralchimp"' >> Gemfile
  gem install bundler
  install_users_gems
  run bundle show feralchimp
  assert_true $status
  assert_string_contains "$output" feralchimp
}

@test "#install_users_gems: vendor/bundle if \$BUNDLE_CACHE with git" {
  echo 'source "https://rubygems.org"' > Gemfile
  echo 'gem "feralchimp", :github => "envygeeks/feralchimp"' >> Gemfile
  echo 'gem "clippy"' >> Gemfile
  gem install bundler
  BUNDLE_CACHE=true install_users_gems
  run bundle list
  assert_dir vendor/bundle
  assert_true $status
  assert_string_contains "$output" feralchimp
  assert_string_contains "$output" clippy
}

@test "#install_user_gems: vendor/bundle if \$BUNDLE_ARGS='--path vendor/bundle'" {
  echo 'source "https://rubygems.org"' > Gemfile
  echo 'gem "feralchimp", :github => "envygeeks/feralchimp"' >> Gemfile
  echo 'gem "clippy"' >> Gemfile
  gem install bundler
  BUNDLE_ARGS="--path vendor/bundle" install_users_gems
  run bundle list
  assert_dir vendor/bundle
  assert_true $status
  assert_string_contains "$output" feralchimp
  assert_string_contains "$output" clippy
}

@test "#make_gemfile_uniq: cleanup the gemfile" {
  echo 'source "https://rubygems.org"' > Gemfile
  echo 'gem "feralchimp"' >> Gemfile
  echo 'group :development do' >> Gemfile
    echo '  gem "pry"' >> Gemfile
  echo 'end' >> Gemfile
  echo '' >> Gemfile
  echo '' >> Gemfile
  echo 'gem "feralchimp"' >> Gemfile
  echo 'group :development do' >> Gemfile
    echo '  gem "hello"' >> Gemfile
  echo 'end' >> Gemfile
  make_gemfile_uniq

  assert_count feralchimp 1
  assert_count "group :development do" 2
  assert_match_count "" 2
}
