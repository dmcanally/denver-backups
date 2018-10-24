define backups::backup (

  Enum['pg_db','mysql_db','file'] $backup_type  = undef,
  Optional[Stdlib::Absolutepath] $backup_file   = undef,
  Optional[String] $backup_db                   = undef,
  Stdlib::Absolutepath $backup_storage_path     = $::backups::backup_storage_path,
  String $backup_user                           = $::backups::backup_user,
  Integer $cron_hour                            = $::backups::cron_hour,
  Integer $cron_minute                          = $::backups::cron_minute,
  String $gpg_keyname                           = $::backups::gpg_keyname,
  String $gpg_keyuid                            = $::backups::gpg_keyuid,

) {

  $gpg_cmd = "gpg -z 9 -r ${gpg_keyuid} -e > ${backup_storage_path}"

  case $backup_type {
    'pg_db': {
      cron { $name:
        command => "/bin/su - postgres -c \"/bin/pg_dump -c ${backup_db}\" | ${gpg_cmd}/${backup_db}-db-\$(date +%m%d%Y-%H%M).sql.gz.gpg",
        user    => $backup_user,
        hour    => $cron_hour,
        minute  => $cron_minute,
      }
    }
    'mysql_db': {
      cron { $name:
        command => "/bin/su - postgres -c \"/bin/pg_dump -c ${backup_db}\" | ${gpg_cmd}/${backup_db}-db-\$(date +%m%d%Y-%H%M).sql.gz.gpg",
        user    => $backup_user,
        hour    => $cron_hour,
        minute  => $cron_minute,
      }
    }
    default : {
      cron { $name:
        command => "/bin/tar -c ${backup_file} | ${gpg_cmd}/${name}-\$(date +%m%d%Y-%H%M).tar.gz.gpg",
        user    => $backup_user,
        hour    => $cron_hour,
        minute  => $cron_minute,
      }
    }
  }
}
