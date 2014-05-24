class duplicity (
  $ensure = present,
  $packages = undef,
  $script_directory = '/var/spool/duplicity'
) {

  if $packages == undef {
    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
      $_packages = ['duplicity','gnupg2']
    }
  }
  else {
    $_packages = $packages
  }

  package { $_packages:
    ensure => $ensure
  }

  file { "script directory":
    ensure => 'directory',
    path => "$script_directory"
  }
}
