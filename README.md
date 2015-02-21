# puppet-ttrss

This Puppet module contains configuration for Tiny Tiny RSS.

## Build Status

[![Build Status](https://travis-ci.org/jpds/puppet-ttrss.svg?branch=master)](https://travis-ci.org/jpds/puppet-ttrss)

## Example usage

Parameters for module configuration:
```
class { 'ttrss':
  dbname               => 'ttrss',
  dbusername           => 'ttrss',
  dbpassword           => 'password',
  dbserver             => 'localhost',
  dbtype               => 'pgsql',
  enable_update_daemon => true,
  single_user_mode     => true,
  ttrsspath            => 'http://news.example.com',
}
```

This module only installs and configures Tiny Tiny RSS. It does not install a
web or database server for the application - this is intended to be handled by
their specific module, below is an example Puppet configuration for the latter:

```
class { 'apache':
  default_mods        => false,
  default_confd_files => false,
  mpm_module          => 'prefork',
}

apache::vhost { 'news.example.com':
  servername => 'news.example.com',
  port    => '80',
  docroot => '/usr/share/tt-rss/www',
}

include apache::mod::php

class { 'postgresql::server': }

postgresql::server::db { 'ttrss':
  user     => 'ttrss',
  password => postgresql_password('ttrss', 'password'),
}
```

## License

See [LICENSE](LICENSE) file.
