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
        :enable_update_daemon => true,
        :single_user_mode     => true,
        :ttrsspath            => 'http://news.example.com',
      }
    end

    it { should compile }
    it { should contain_package('tt-rss') \
      .that_comes_before('File[/etc/tt-rss/config.php]') }
    it { should contain_file('/etc/tt-rss/config.php') \
      .with_path('/etc/tt-rss/config.php') }
    it {
      should contain_file('/etc/tt-rss/config.php').with(
        'ensure' => 'file',
        'path'   => '/etc/tt-rss/config.php',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
      )
    }
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
