# == Class: ttrss::service
#
#    This class should not be called directly.
#

class ttrss::service(
    $enable_update_daemon = $ttrss::params::enable_update_daemon,
) inherits ttrss::params {
    service { 'tt-rss':
        ensure    => $enable_update_daemon,
        subscribe => File['/etc/default/tt-rss'],
    }
}
