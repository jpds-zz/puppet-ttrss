# == Class: ttrss::service
#
#    This class should not be called directly.
#

class ttrss::service(
) inherits ttrss::params {
    service { 'tt-rss':
        ensure    => $ttrss::params::enable_update_daemon,
        subscribe => File['/etc/default/tt-rss'],
    }
}
