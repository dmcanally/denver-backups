require 'spec_helper'

describe 'backups::backup' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :title do 'test' end

      let :facts do
        facts
      end

      let :pre_condition do
        "class { '::backups':
           gpg_keyfile => 'pubkey.gpg',
           gpg_keyid   => 'mykey',
        }"
      end

      describe 'file backup' do
        let :params do {
          :backup_type => 'file',
	  :backup_file => '/tmp/test.txt',
        } end

	it { should compile.with_all_deps }

      end

      describe 'pg_db backup' do
        let :params do {
          :backup_type => 'pg_db',
          :backup_db   => 'pgtest',
        } end

	it { should compile.with_all_deps }

      end

      describe 'mysql_db' do
        let :params do {
          :backup_type => 'mysql_db',
          :backup_db   => 'mysqltest',
        } end

	it { should compile.with_all_deps }

      end

    end
  end
end
