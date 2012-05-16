# Class: apache::wsgi
#
# This class installs Apache Python WSGI capabilities
#
# Parameters:
# - The $wsgi_package name from the apache::params class
#
# Actions:
#   - Install Apache Python WSGI capabilities
#
# Requires:
#
# Sample Usage:
#
class apache::wsgi {

  include apache

  package { 'apache_wsgi_package':
    name    => "$apache::params::wsgi_package",
    ensure  => installed,
    require => Package['httpd'],
  }

  case $::osfamily {
    RedHat: {
      file { 'apache_wsgi':
        path => "${apache::params::mod_conf_dir}/wsgi.conf",
        ensure => present,
        source => "puppet:///modules/apache/mod/${::osfamily}/wsgi.conf",
        mode => 0644,
        owner => root,
        group => root,
      }
    }
    Debian: {
      a2mod { 'wsgi': ensure => present, }
    }
  }
}
