# class backups
class backups (

  Stdlib::Absolutepath $backup_homedir      = '/opt/backups',
  String $backup_user                       = 'backups',
  String $backup_group                      = 'backups',
  Integer $cron_hour                        = 0,
  Integer $cron_minute                      = 0,
  String $gpg_keyfile                       = undef,
  String $gpg_keyuid                        = undef,
  Hash[String, Hash] $backup                = {},

) {

  if !defined(Package['gnupg2']) {
    package { 'gnupg2':
      ensure => installed,
    }
  }

  user { $backup_user:
    ensure => 'present',
    gid    => $backup_group,
    home   => $backup_homedir,
    shell  => '/bin/bash',
  }

  file { $backup_homedir:
    ensure  => directory,
    owner   => $backup_user,
    group   => $backup_group,
    mode    => '0750',
    require => User[$backup_user],
  }

  file { $backup_storage_path:
    ensure  => directory,
    owner   => $backup_user,
    group   => $backup_group,
    mode    => '0750',
    require => File[$backup_homedir],
  }

  file { "${backup_homedir}/${gpg_keyfile}":
    ensure  => file,
    owner   => $backup_user,
    group   => $backup_group,
    mode    => '0640',
    require => File[$backup_homedir],
  }

  exec { 'impoort_gpgkey':
    user    => $backup_user,
    path    => ['/sbin','/bin','/usr/sbin','/usr/bin'],
    command => "gpg --import ${backup_homedir}/${gpg_keyfile}; echo -e \'trust\\n5\\ny\\nquit\\n\' | gpg --command-fd 0 --edit-key ${gpg_keyuid}",
    unless  => "gpg -k ${gpg_keyuid}",
    require => [File["${backup_homedir}/${gpg_keyfile}"],Package['gnupg2']],
  }

  create_resources('backups::backup', $backup)

}
