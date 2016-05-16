define duplicity::job(
  $directories        = [],
  $flags              = [],
  $options            = {},
  $env_vars           = {},
  $target_url         = undef,
  $remove_older_than  = false,
  $hour               = '1',
  $minute             = '0',
  $pre_commands       = [],
  $post_commands      = [],
  $shell              = '/bin/bash'
) {

  include ::duplicity

  $script_path = "${duplicity::script_directory}/${name}"
  $log_path = "${duplicity::log_directory}/${name}.log"

  $_flags = $flags
  $_options = $options
  $_env_vars = $env_vars

  file { $script_path:
    ensure  => file,
    mode    => '0700',
    path    => $script_path,
    content => template('duplicity/script.erb'),
    require => File[$duplicity::script_directory]
  } ->
  cron { $script_path:
    ensure  => present,
    command => "${script_path} >${log_path} || echo 'Duplicity backup failed'",
    hour    => $hour,
    minute  => $minute
  }
}
