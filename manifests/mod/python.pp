class apache::mod::python {
  include apache

  package { 'mod_python_package':
    ensure  => installed,
    name    => $apache::params::python_package,
    require => Package['httpd'];
  }

  a2mod { 'python': ensure => present; }

}


