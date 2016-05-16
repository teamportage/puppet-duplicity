require 'spec_helper'

describe 'duplicity::job::s3', :type => :define do

  let(:facts) {{ :osfamily => 'RedHat' }}
  let(:title) { 'test' }
  let(:script_file) { "/var/spool/duplicity/#{title}" }
  let(:params) do
    {
      'directories' => ['/root', '/home'],
      'access_key_id' => 'asdaetua5uazfba',
      'secret_access_key' => 'asgfaeara5atir69ga',
      'destination' => "backups/host",
    }
  end

  it {
    should contain_class('duplicity::s3')
  }

  it {
    should contain_file("#{script_file}").with({ 'ensure' => 'file'})

    [
      /^#!\/bin\/bash$/,
      /^export AWS_ACCESS_KEY_ID='asdaetua5uazfba'$/,
      /^export AWS_SECRET_ACCESS_KEY='asgfaeara5atir69ga'$/,
      /^  s3\+http:\/\/backups\/host$/
    ].each do |line|
      should contain_file("#{script_file}").with_content(line)
    end
  }
end
