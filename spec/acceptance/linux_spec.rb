require 'spec_helper_acceptance'

describe 'Simple Application' do

  ssh_service = case fact('osfamily')
                 when 'Debian'
                   'ssh'
                 when 'RedHat'
                   'sshd'
                 else
                   'undef'
                 end

  cron_package = case fact('osfamily')
                 when 'Debian'
                   'cron'
                 when 'RedHat'
                   'cronie'
                 else
                   'undef'
                 end


  let(:pp) do
    <<-EOS
    class { '::base': 
      timezone         => 'UTC',
      external_ip4     => '127.0.0.1',
      enable_itsysrepo => false,
      enable_filebeat  => false,
      enable_sudorules => false,
      packages         => ['openssh-server','#{cron_package}',],
      monitor_host     => 'netdata.example.com',
      netdata_apikey   => 'd41645a8-74ca-4fc3-a574-09d749e5a925',
    }

    EOS
  end

  it_behaves_like 'a idempotent resource'

  describe service(ssh_service) do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe service('zabbix-agent') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe service('puppet') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

end
