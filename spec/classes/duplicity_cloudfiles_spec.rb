require 'spec_helper'

describe 'duplicity::cloudfiles', :type => :class do

  let(:facts) {{:osfamily => 'RedHat'}}

  context 'with defaults' do
    it {
      should contain_class('duplicity')
      should contain_class('duplicity::cloudfiles')
    }
    ['python-cloudfiles'].each do |package|
      it {
        should contain_package("#{package}").with({
          'ensure' => 'present'
        })
      }
    end 
  end
end
