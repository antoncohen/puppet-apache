# Class: apache::python
#
# This class installs Apache Python capabilities
#
# Parameters:
# - The $python_package name from the apache::params class
#
# Actions:
#   - Install Apache Python capabilities
#
# Requires:
#
# Sample Usage:
#
class apache::python {

  include apache

  package { 'apache_python_package':
    name    => "$apache::params::python_package",
    ensure  => installed,
    require => Package['httpd'],
  }

  case $::osfamily {
    RedHat: {
      file { 'apache_python':
        path => "${apache::params::mod_conf_dir}/python.conf",
        ensure => present,
        source => "puppet:///modules/apache/mod/${::osfamily}/python.conf",
        mode => 0644,
        owner => root,
        group => root,
      }
    }
    Debian: {
      a2mod { 'python': ensure => present, }
    }
  }
}
