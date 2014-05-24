require 'spec_helper'

describe 'duplicity::job::cloudfiles', :type => :define do

  describe 'no global cloudfiles settings' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    let(:title) { 'test' }
    let(:script_file) { "/var/spool/duplicity/#{title}" }
    let(:params) {{
        'directories' => ['/root', '/home'],
        'username' => 'account',
        'api_key' => 'asgfaetir69ga',
        'container' => "backups",
    }}

    it {
      should contain_class('duplicity::cloudfiles')
    }

    it {
      should contain_file("#{script_file}") \
        .with({ 'ensure' => 'file'})

      [
        /^export CLOUDFILES_USERNAME='account'$/,
        /^export CLOUDFILES_APIKEY='asgfaetir69ga'$/,
        /^  cf\+http:\/\/backups$/
      ].each do |line|
        should contain_file("#{script_file}").with_content(line)
      end
    }
  end

  describe 'global cloudfiles settings' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    let(:pre_condition) {
      'class { duplicity::cloudfiles:
        username => "account",
        api_key => "adfarze5ua5y"
      }
      '
    }
    let(:title) { 'test' }
    let(:script_file) { "/var/spool/duplicity/#{title}" }
    let(:params) {{
        'directories' => ['/root', '/home'],
        'container' => "backups"
    }}

    it {
      [
        /^export CLOUDFILES_USERNAME='account'$/,
        /^export CLOUDFILES_APIKEY='adfarze5ua5y'$/,
        /^  cf\+http:\/\/backups$/
      ].each do |line|
        should contain_file("#{script_file}").with_content(line)
      end 
    }
  end
end
