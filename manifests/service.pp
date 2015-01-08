# == Class: ttrss::service
#
#    This class should not be called directly.
#

class ttrss::service {
    service { 'tt-rss':
        ensure    => $enable_update_daemon,
        subscribe => File['/etc/default/tt-rss'],
    }
}
