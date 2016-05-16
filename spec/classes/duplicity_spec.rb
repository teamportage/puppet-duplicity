require 'spec_helper'

describe 'duplicity', :type => :class do

  let(:facts) {{:osfamily => 'RedHat'}}

  context 'with defaults' do
    it {
      should contain_class('duplicity')
    }

    it {
      should contain_file('/var/spool/duplicity').with({
        'ensure'  => 'directory',
        'recurse' => true,
        'purge' => true
      })
    }

    it {
      should contain_file('/var/log/duplicity').with({
        'ensure'  => 'directory',
        'recurse' => true,
        'purge' => true
      })
    }

    ['duplicity', 'gnupg2'].each do |package|
      it {
        should contain_package("#{package}").with({
          'ensure' => 'present'
        })
      }
    end 
  end 
end
