# Definition: apache::conf
#
# This class installs Apache configuration files
#
# Parameters:
# - $content is the .erb template to use.
# - $source is the source file to use.
#
# Actions:
# - Install Apache configuration files
#
# Requires:
# - The apache class
#
# Sample Usage:
#  apache::conf { 'ssl':
#    content => 'apache/ssl.conf.erb',
#  }
# OR
#  apache::conf { 'security':
#    source => 'puppet:///modules/name_of_module/filename',
#  }
#
define apache::conf(
    $source = undef,
    $content = undef,
  ) {

  include apache

  if ($source != undef) and ($content != undef) {
    fail('apache::config: Must define $source OR $content. Not both.')
  } elsif ($source == undef) and ($content == undef) {
    fail('apache::config: Must define $source OR $content.')
  } elsif $source {
    file { "apache.${name}.conf":
        name    => "${apache::params::confd}/${name}.conf",
        source  => $source,
        owner   => 'root',
        group   => 'root',
        mode    => '755',
        require => Package['httpd'],
        notify  => Service['httpd'],
    }
  } elsif $content {
     file { "${name}.conf":
        name    => "${apache::params::confd}/${name}.conf",
        content => template($content),
        owner   => 'root',
        group   => 'root',
        mode    => '755',
        require => Package['httpd'],
        notify  => Service['httpd'],
    }
  }
}
