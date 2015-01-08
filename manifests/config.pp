# == Class: ttrss::config
#
#    This class should not be called directly.
#

class ttrss::config(
    $ttrsspath = "http://www.example.com/tt-rss",
    $single_user_mode = false,
    $dbname = "ttrss",
    $dbusername = undef,
    $dbpassword = undef,
    $dbtype = undef,
    $enable_update_daemon = false,
) {
    if $enable_update_daemon {
        $update_daemon = 0
    } else {
        $update_daemon = 1
    }

    file { '/etc/tt-rss/config.php':
        ensure  => file,
        content => template('ttrss/config.php.erb'),
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
    }

    file { '/etc/tt-rss/database.php':
        ensure  => file,
        content => template('ttrss/database.php.erb'),
        mode    => '0640',
        owner   => 'root',
        group   => 'www-data',
    }

    file { '/etc/default/tt-rss':
        ensure  => file,
        content => template('ttrss/default/tt-rss.erb'),
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
    }

    case $dbtype {
        "mysql": { $php_db_package = 'php5-mysql' }
        "pgsql": { $php_db_package = 'php5-pgsql' }
        default: { fail("Valid database backend required, found ${dbtype}") }
    }

    package { "$php_db_package":
        ensure => "present",
    }
}
