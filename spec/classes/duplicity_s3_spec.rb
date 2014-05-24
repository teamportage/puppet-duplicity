require 'spec_helper'

describe 'duplicity::s3', :type => :class do

  let(:facts) {{:osfamily => 'RedHat'}}

  context 'with defaults' do
    it {
      should contain_class('duplicity')
      should contain_class('duplicity::s3')
    }
    ['python-boto'].each do |package|
      it {
        should contain_package("#{package}").with({
          'ensure' => 'present'
        })
      }
    end 
  end
end
