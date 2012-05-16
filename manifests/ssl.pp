# Class: apache::ssl
#
# This class installs Apache SSL capabilities
#
# Parameters:
# - The $ssl_package name from the apache::params class
#
# Actions:
#   - Install Apache SSL capabilities
#
# Requires:
#
# Sample Usage:
#
class apache::ssl {

  include apache

  package { 'apache_ssl_package':
    name    => "$apache::params::ssl_package",
    ensure  => installed,
    require => Package['httpd'],
  }

  case $::osfamily {
    RedHat: {
      file { 'apache_ssl':
        path => "${apache::params::mod_conf_dir}/ssl.conf",
        ensure => present,
        source => "puppet:///modules/apache/mod/${::osfamily}/ssl.conf",
        mode => 0644,
        owner => root,
        group => root,
      }
    }
    Debian: {
      a2mod { 'ssl': ensure => present, }
    }
  }
}
