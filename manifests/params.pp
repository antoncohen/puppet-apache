# Class: apache::params
#
# This class manages Apache parameters
#
# Parameters:
# - The $user that Apache runs as
# - The $group that Apache runs as
# - The $apache_name is the name of the package and service on the relevant distribution
# - The $php_package is the name of the package that provided PHP
# - The $ssl_package is the name of the Apache SSL package
# - The $apache_dev is the name of the Apache development libraries package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class apache::params {

  $ssl           = 'true'
  $template      = 'apache/vhost-default.conf.erb'
  $priority      = '25'
  $servername    = ''
  $serveraliases = ''
  $auth          = false
  $redirect_ssl  = false
  $options       = 'Indexes FollowSymLinks MultiViews'
  $vhost_name    = '*'

  case $operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific': {
       $apache_name = 'httpd'
       $user = 'apache'
       $group = 'apache'
       $perl_package = 'mod_perl'
       $php_package = 'php'
       $python_package = 'mod_python'
       $wsgi_package = 'mod_wsgi'
       $ssl_package = 'mod_ssl'
       $apache_dev  = 'httpd-devel'
       $vdir = '/etc/httpd/conf.d'
       $confd = '/etc/httpd/conf.d'
       $mod_conf_dir = '/etc/httpd/conf.d'
       $docroot = '/var/www/html'
    }
    'ubuntu', 'debian': {
       $apache_name = 'apache2'
       $user = 'www-data'
       $group = 'www-data'
       $perl_package = 'libapache2-mod-perl2'
       $php_package = 'libapache2-mod-php5'
       $python_package = 'libapache2-mod-python'
       $wsgi_package = 'libapache2-mod-wsgi'
       $ssl_package = 'apache-ssl'
       $apache_dev  = [ 'libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev' ]
       $vdir = '/etc/apache2/sites-enabled'
       $confd = '/etc/apache2/conf.d'
       $mod_conf_dir = '/etc/apache2/mods-enabled'
       $docroot = '/var/www'
    }
    default: {
       $apache_name = 'apache2'
       $user = 'www-data'
       $group = 'www-data'
       $perl_package = 'libapache2-mod-perl2'
       $php_package = 'libapache2-mod-php5'
       $python_package = 'libapache2-mod-python'
       $wsgi_package = 'libapache2-mod-wsgi'
       $ssl_package = 'apache-ssl'
       $apache_dev  = 'apache-dev'
       $vdir = '/etc/apache2/sites-enabled'
       $confd = '/etc/apache2/conf.d'
       $mod_conf_dir = '/etc/apache2/mods-enabled'
       $docroot = '/var/www'
    }
  }
}
