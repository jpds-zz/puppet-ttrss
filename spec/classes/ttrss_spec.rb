require 'spec_helper'

describe 'ttrss', :type => 'class' do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    let :params do
      {
        :dbname               => 'ttrss',
        :dbusername           => 'ttrss',
        :dbpassword           => 'password',
        :dbserver             => 'localhost',
        :dbtype               => 'pgsql',
        :enable_update_daemon => false,
        :single_user_mode     => true,
        :ttrsspath            => 'http://news.example.com',
      }
    end

    it { should compile }
    it { should contain_package('tt-rss') \
      .that_comes_before('File[/etc/tt-rss/config.php]') }
    it {
      should contain_file('/etc/tt-rss/config.php').with(
        'ensure' => 'file',
        'path'   => '/etc/tt-rss/config.php',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
      )
    }
    it {
      should contain_file('/etc/default/tt-rss').with(
        'ensure' => 'file',
        'path'   => '/etc/default/tt-rss',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
      ).with_content(/^DISABLED=1$/)
    }
    it { should contain_service('tt-rss').with_ensure(false) }

    context 'enable_update_daemon => true' do
      let :params do
        super().merge({
          :enable_update_daemon => true
        })
      end

      it do
        should contain_file('/etc/default/tt-rss') \
          .with_content(/^DISABLED=0$/)
      end

      it { should contain_service('tt-rss').with_ensure(true) }
    end

  end

  context "on an unknown OS" do
    let :facts do
      {
        :osfamily => 'Darwin'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end
end
