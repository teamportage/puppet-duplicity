class duplicity::s3 (
  $ensure = present,
  $packages = undef,
  $access_key_id = undef,
  $secret_access_key = undef
) {

  if $packages == undef {
    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
      $_packages = ['python-boto']
    }
  }
  else {
    $_packages = $packages
  }

  package { $_packages:
    ensure => $ensure
  }
}
