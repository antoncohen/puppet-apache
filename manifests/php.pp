# Class: apache::php
#
# This class installs Apache PHP capabilities
#
# Parameters:
# - The $php_package name from the apache::params class
#
# Actions:
#   - Install Apache PHP capabilities
#
# Requires:
#
# Sample Usage:
#
class apache::php {

  include apache

  package { 'apache_php_package':
    name    => "$apache::params::php_package",
    ensure  => installed,
    require => Package['httpd'],
  }

  case $::osfamily {
    RedHat: {
      file { 'apache_php':
        path => "${apache::params::mod_conf_dir}/php.conf",
        ensure => present,
        source => "puppet:///modules/apache/mod/${::osfamily}/php.conf",
        mode => 0644,
        owner => root,
        group => root,
      }
    }
    Debian: {
      a2mod { 'php5': ensure => present, }
    }
  }
}
