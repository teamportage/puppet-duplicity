class duplicity::cloudfiles (
  $ensure = present,
  $packages = undef,
  $username = undef,
  $api_key = undef
) {

  if $packages == undef {
    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
      $_packages = ['python-cloudfiles']
    }
  }
  else {
    $_packages = $packages
  }

  package { $_packages:
    ensure => $ensure
  }
}
