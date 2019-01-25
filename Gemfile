source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 4.0','<6.0']
gem 'metadata-json-lint', '>=2.0.2'
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 1.0.0'
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '>= 1.7.0'
gem 'rspec-puppet','2.6.15'
gem 'semantic_puppet'
gem 'rspec-puppet-facts', '>= 1.7'
gem 'beaker', '~> 3.33', {"groups"=>["system_tests"]}
gem 'beaker-rspec', {"groups"=>["system_tests"]}
gem 'beaker-docker'
gem 'beaker-module_install_helper', {"groups"=>["system_tests"]}
gem 'beaker-puppet_install_helper', {"groups"=>["system_tests"]}

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
  gem 'rake', '~> 10.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop'
end

gem 'coveralls', require: false
