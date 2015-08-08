source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
    puppetversion = "= #{ENV['PUPPET_VERSION']}"
else
    puppetversion = ['3.8.1']
end

gem 'puppet', puppetversion
gem 'puppet-lint'
gem 'rspec-core', '3.1.7'
gem 'rspec'
gem 'rspec-puppet'
gem 'puppetlabs_spec_helper'
