# Class: apache::perl
#
# This class installs Apache Perl capabilities
#
# Parameters:
# - The $perl_package name from the apache::params class
#
# Actions:
#   - Install Apache Perl capabilities
#
# Requires:
#
# Sample Usage:
#
class apache::perl {

  include apache

  package { 'apache_perl_package':
    name    => "$apache::params::perl_package",
    ensure  => installed,
    require => Package['httpd'],
  }

  case $::osfamily {
    RedHat: {
      file { 'apache_perl':
        path => "${apache::params::mod_conf_dir}/perl.conf",
        ensure => present,
        source => "puppet:///modules/apache/mod/${::osfamily}/perl.conf",
        mode => 0644,
        owner => root,
        group => root,
      }
    }
    Debian: {
      a2mod { 'perl': ensure => present, }
    }
  }
}
