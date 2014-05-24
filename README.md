puppet-duplicity
================

[![Build Status](https://travis-ci.org/JCotton1123/puppet-duplicity.svg?branch=master)](https://travis-ci.org/JCotton1123/puppet-duplicity)

Puppet module for managing duplicity backups

## Typical Usage

```puppet
class { duplicity::cloudfiles:
  username => 'account',
  api_key => 'fsgzet6uis54ag4sfgae5a4'
}
```

```puppet
duplicity::job::cloudfiles { 'example':
  directories => ['/root', '/home', '/var/www'],
  container => "backups-$::fqdn",
  hour => '4',
  minute => '0',
  remove_older_than => '30D',
  options => {
    '--full-if-older-than' => '7D' 
  }
}
```

### No encryption

```puppet
duplicity::job::cloudfiles { 'example':
  directories => ['/root', '/home', '/var/www'],
  container => "backups-$::fqdn",
  hour => '4',
  minute => '0',
  flags => ['--no-encryption']
}
```

### Symmetric encryption

```puppet
duplicity::job::cloudfiles { 'example':
  directories => ['/root', '/home', '/var/www'],
  container => "backups-$::fqdn",
  hour => '4',
  minute => '0',
  env_vars => {
    'PASSPHRASE' => 'wesetsiccyCablukkia'
  }
}
```

### Asymmetric encryption

When using asymmetric encryption you must pass the gpg key id to duplicity.

```puppet
duplicity::job::cloudfiles { 'example':
  directories => ['/root', '/home', '/var/www'],
  container => "backups-$::fqdn",
  hour => '4',
  minute => '0',
  options => {
    '--encrypt-id' => '4C1DDCD3'
  }
}
```

