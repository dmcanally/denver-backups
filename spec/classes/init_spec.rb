require 'spec_helper'

describe 'backups' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      facts.merge!({ 
      })

      let(:params) do
        {
        }.merge(overridden_params)
      end

      describe "apply backups on #{os}" do
        let(:overridden_params) do {
          :gpg_keyfile => 'pubkey.gpg',
          :gpg_keyid   => 'mykey',
        } end

        it { should compile.with_all_deps }

      end
    end
  end
end
