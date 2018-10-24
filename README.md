# base

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Development](#development)

## Description

This module will deploy a user, a public gpg key, and a cron job to create backup artifacts.

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
