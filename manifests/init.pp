# == Class: ttrss
#
# Sets up ttrss with a set of rules.
#

class ttrss(
    $dbname               = undef,
    $dbusername           = undef,
    $dbpassword           = undef,
    $dbserver             = undef,
    $dbtype               = undef,
    $enable_update_daemon = $ttrss::params::enable_update_daemon,
    $single_user_mode     = false,
    $ttrsspath            = 'http://www.example.com/tt-rss',
) inherits ttrss::params {
  if ($::osfamily != 'Debian') {
    fail("${::operatingsystem} not supported")
  }

  anchor { 'ttrss::begin': } ->
  class { 'ttrss::package': } ->
  class { 'ttrss::config':
    dbname               => $dbname,
    dbusername           => $dbusername,
    dbpassword           => $dbpassword,
    dbserver             => $dbserver,
    dbtype               => $dbtype,
    enable_update_daemon => $ttrss::params::enable_update_daemon,
    single_user_mode     => $single_user_mode,
    ttrsspath            => $ttrsspath,
  }
  class { 'ttrss::service': } ->
  anchor { 'ttrss::end': }

  Anchor['ttrss::begin']  ~> Class['ttrss::service']
  Class['ttrss::package'] ~> Class['ttrss::service']
  Class['ttrss::config']  ~> Class['ttrss::service']
}
