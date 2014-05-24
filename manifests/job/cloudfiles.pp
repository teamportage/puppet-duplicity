define duplicity::job::cloudfiles (
  $container          = undef,
  $username           = undef,
  $api_key            = undef,
  $directories        = [],
  $flags              = [],
  $options            = {},
  $env_vars           = {},
  $remove_older_than  = false,
  $hour               = '1',
  $minute             = '0',
  $pre_commands       = [],
  $post_commands      = [],
  $shell              = '/bin/bash'
) {

  include ::duplicity
  include ::duplicity::cloudfiles

  $_username = $username ? {
    undef   => $duplicity::cloudfiles::username,
    default => $username
  }

  $_api_key = $api_key ? {
    undef   => $duplicity::cloudfiles::api_key,
    default => $api_key
  }

  $_env_vars = merge($env_vars, {
    'CLOUDFILES_USERNAME' => $_username,
    'CLOUDFILES_APIKEY'   => $_api_key
  })

  $_target_url = "cf+http://${container}"

  duplicity::job { $name:
    directories        => $directories,
    flags              => $flags,
    options            => $options,
    env_vars           => $_env_vars,
    target_url         => $_target_url,
    remove_older_than  => $remove_older_than,
    hour               => $hour,
    minute             => $minute,
    pre_commands       => $pre_commands,
    post_commands      => $post_commands,
    shell              => $shell
  }
}
