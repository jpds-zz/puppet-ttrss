# == Class: ttrss
#
# Sets up ttrss with a set of rules.
#

class ttrss(
    $dbtype = 'asdf',
    $single_user_mode = false,
) {
  if ($::osfamily != 'Debian') {
    fail("${::operatingsystem} not supported")
  }

  anchor { 'ttrss::begin': } ->
  class { 'ttrss::package': } ->
  class { 'ttrss::config':
    dbtype           => $dbtype,
    single_user_mode => $single_user_mode,
  }
  class { 'ttrss::service': } ->
  anchor { 'ttrss::end': }

  Anchor['ttrss::begin']  ~> Class['ttrss::service']
  Class['ttrss::package'] ~> Class['ttrss::service']
  Class['ttrss::config']  ~> Class['ttrss::service']
}
