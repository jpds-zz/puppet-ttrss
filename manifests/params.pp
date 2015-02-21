# Default MoinMoin parameters for different operating systems.
class ttrss::params {
  case $::osfamily {
    'Debian': {
      $package  = 'tt-rss'
    }

    default: {
      fail("${::osfamily} is not supported.")
    }
  }

  $enable_update_daemon = false
}
