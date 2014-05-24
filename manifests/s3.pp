class duplicity::s3 (
  $ensure            = present,
  $packages          = undef,
  $access_key_id     = undef,
  $secret_access_key = undef
) {

  include duplicity

  if $packages == undef {
    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
      $_packages = ['python-boto']
    }
    else {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
  else {
    $_packages = $packages
  }

  package { $_packages:
    ensure => $ensure
  }
}
