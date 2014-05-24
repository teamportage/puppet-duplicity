class duplicity::cloudfiles (
  $ensure   = present,
  $packages = undef,
  $username = undef,
  $api_key  = undef
) {

  include duplicity

  if $packages == undef {
    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
      $_packages = ['python-cloudfiles']
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
