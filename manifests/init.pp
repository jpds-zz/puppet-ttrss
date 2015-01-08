class ttrss {
    package { 'tt-rss':
        ensure => installed,
        before => File['/etc/tt-rss/config.php'],
    }

    $ttrsspath = "http://www.example.com/tt-rss"
    $single_user_mode = false
    $dbname = "ttrss"
    $dbusername = undef
    $dbpassword = undef
    $dbtype = undef

    $enable_update_daemon = false

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

    service { 'tt-rss':
        ensure    => $enable_update_daemon,
        subscribe => File['/etc/default/tt-rss'],
    }

    $php_db_package = $dbtype ? {
        mysql => 'php5-mysql',
        pgsql => 'php5-pgsql',
    }

    package { "$php_db_package":
        ensure => "present",
    }
}
