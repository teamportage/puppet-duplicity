define duplicity::job(
  $directories = [],
  $flags = [],
  $options = {},
  $env_vars = {},
  $target_url = undef,
  $full_if_older_than = '7D',
  $remove_older_than = false,
  $hour = "1",
  $minute = "00",
  $pre_commands = [],
  $post_commands = [],
  $shell = "/bin/bash",
  $user = 'root'
) {

  include ::duplicity

  $script_path = "$duplicity::script_directory/$name"
  
  file { "$name":
    ensure => present,
    owner => $user,
    mode => '0700',
    path => $script_path,
    content => template("duplicity/script.erb"),
    require => File["script directory"]
  } ->
  cron { "$name":
    ensure => present,
    command => $script_path,
    user => $user,
    hour => $hour,
    minute => $minute
  }
}
