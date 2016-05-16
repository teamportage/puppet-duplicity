class duplicity (
  $ensure            = present,
  $packages          = undef,
  $script_directory  = '/var/spool/duplicity',
  $log_directory     = '/var/log/duplicity'
) {

  if $packages == undef {
    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
      $_packages = ['duplicity','gnupg2']
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

  file { $script_directory:
    ensure  => 'directory',
    recurse => true,
    purge   => true
  }

  file { $log_directory:
    ensure  => 'directory',
    recurse => true,
    purge   => true
  }
}
