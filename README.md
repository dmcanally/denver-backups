# base

[![Build Status](https://travis-ci.org/dmcanally/denver-backups.svg?branch=master)](https://travis-ci.org/dmcanally/denver-backups)
[![Code Coverage](https://coveralls.io/repos/github/dmcanally/denver-backups/badge.svg?branch=master)](https://coveralls.io/github/dmcanally/denver-backups)
[![Puppet Forge](https://img.shields.io/puppetforge/v/denver/backups.svg)](https://forge.puppetlabs.com/denver/backups)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/denver/backups.svg)](https://forge.puppetlabs.com/denver/backups)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/denver/backups.svg)](https://forge.puppetlabs.com/denver/backups)

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Development](#development)

## Description

This module will deploy a user to execute backups and a cron job to create encrypted backup artifacts.

## Usage

### Linux 
Backing up a directory
```ruby
class { '::backups':
  gpg_keyfile => 'pubkey.gpg'
  gpg_keyid   => 'keyname'
}

backups::backup { 'service-name':
  backup_type => 'file',
  backup_file => '/etc/conf/dir', 
  cron_hour   => 1,
  cron_minute => 30,
}
```

Backing up a postgres database.
```ruby
class { '::backups':
  gpg_keyfile => 'pubkey.gpg'
  gpg_keyid   => 'keyname'
}

backups::backup { 'postgresdbname':
  backup_type => 'pg_db',
  backup_db   => 'dbname',
}
```

Backing up a mysql database.
```ruby
class { '::backups':
  gpg_keyfile => 'pubkey.gpg'
  gpg_keyid   => 'keyname'
}

backups::backup { 'mysqldbname':
  backup_type => 'mysql_db',
  backup_db   => 'dbname',
}
```

## Development

When adding to this module, be sure to add and update the unit tests where appropriate. You can run the tests locally with the following commands...

To execute general tests (lint, validate, spec)
```bash
bundle install
bundle exec rake test
```
