# == Class: ttrss::package
#
#  This class shouldn't be called directly
#
class ttrss::package {
    package { 'tt-rss':
        ensure => installed,
        before => File['/etc/tt-rss/config.php'],
    }
}
