define duplicity::job::s3 (
  $bucket = undef,
  $access_key_id = undef,
  $secret_access_key = undef,
  $directories = [],
  $flags = [],
  $options = {},
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
  include ::duplicity::s3

  $_access_key_id = $access_key_id ? {
    undef => $duplicity::s3::access_key_id,
    default => $access_key_id
  }

  $_secret_access_key = $secret_access_key ? {
    undef => $duplicity::s3::secret_access_key,
    default => $secret_access_key
  }
  
  $_env_vars = {
    "AWS_ACCESS_KEY_ID" => $_access_key_id,
    "AWS_SECRET_ACCESS_KEY" => $_secret_access_key
  }

  $_target_url = "s3+http://$bucket"

  duplicity::job { "$name":
    directories => $directories,
    flags => $flags,
    options => $options,
    env_vars => $_env_vars,
    target_url => $_target_url,
    full_if_older_than => $full_if_older_than,
    remove_older_than => $remove_older_than,
    hour => $hour,
    minute => $minute,
    pre_commands => $pre_commands,
    post_commands => $post_commands,
    shell => $shell,
    user => $user
  }
}
