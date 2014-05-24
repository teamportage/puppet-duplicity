require 'spec_helper'

describe 'duplicity::job', :type => :define do

  let(:facts) {{ :osfamily => 'RedHat' }}
  let(:title) { 'test' }
  let(:script_file) { "/var/spool/duplicity/#{title}" }
  let(:params) do
    {
      'directories' => ['/root', '/home'],
      'flags' => ['--flag1'],
      'options' => {
        '--option1' => 'opt1-val'
      },
      'env_vars' => {
        'EVAR1' => 'val1'
      },
      'target_url' => 'sftp://user@backupserver/some_dir',
      'pre_commands' => ['mysqldump -u app_bak --all-databases > /usr/backups/mysql.sql'],
      'post_commands' => ['rm /usr/backups/mysql.sql'],
      'remove_older_than' => '14D',
      'hour' => '4',
      'minute' => '0'
    }
  end

  it {
    should contain_class('duplicity')
  }

  it {
    should contain_file("#{script_file}") \
      .with({ 'ensure' => 'file'})

    [
      /^#!\/bin\/bash$/,
      /^export EVAR1='val1'$/,
      /^mysqldump -u app_bak --all-databases > \/usr\/backups\/mysql.sql$/,
      /^duplicity \\$/,
      /^  --flag1 \\$/,
      /^  --option1 opt1-val \\$/,
      /^  --include "\/root" \\$/,
      /^  --include "\/home" \\$/,
      /^  --exclude '\*\*' \\$/,
      /^  sftp:\/\/user@backupserver\/some_dir$/,
      /^duplicity remove-older-than 14D --no-print-statistics --verbosity error sftp:\/\/user@backupserver\/some_dir$/,
      /^rm \/usr\/backups\/mysql.sql$/
    ].each do |line|
      should contain_file("#{script_file}").with_content(line)
    end
  }

  it {
    should contain_cron("#{script_file}") \
      .with_command("#{script_file}") \
      .with_hour(4) \
      .with_minute(0)
  }
end
