# == Class: ttrss::config
#
#    This class should not be called directly.
#

class ttrss::config(
    $dbname               = undef,
    $dbusername           = undef,
    $dbpassword           = undef,
    $dbtype               = undef,
    $enable_update_daemon = false,
    $single_user_mode     = false,
    $ttrsspath            = "http://www.example.com/tt-rss",
) {
    if $enable_update_daemon {
        $update_daemon = 0
    } else {
        $update_daemon = 1
    }

    if ! $dbname {
        fail("No database name specified.")
    }

    if ! $dbusername {
        fail("No database username specified.")
    }

    if ! $dbpassword {
        fail("No database password specified.")
    }

    case $dbtype {
        "mysql": { $php_db_package = 'php5-mysql' }
        "pgsql": { $php_db_package = 'php5-pgsql' }
        default: { fail("Valid database backend required, found '${dbtype}'") }
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

    package { "$php_db_package":
        ensure => "present",
    }
}
