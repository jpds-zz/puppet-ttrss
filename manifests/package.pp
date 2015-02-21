# == Class: ttrss::package
#
#  This class shouldn't be called directly
#
class ttrss::package(
) inherits ttrss::params {
    package { $ttrss::params::package:
        ensure => installed,
        before => File['/etc/tt-rss/config.php'],
    }
}
