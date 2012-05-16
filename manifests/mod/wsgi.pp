class apache::mod::wsgi {
  include apache

  package { 'mod_wsgi_package':
    ensure  => installed,
    name    => $apache::params::wsgi_package,
    require => Package['httpd'];
  }

  a2mod { 'wsgi': ensure => present; }

}

