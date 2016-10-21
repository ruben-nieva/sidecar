# Class: sidecar::params
#
# This class configures parameters for the puppet graylog sidecar module.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class sidecar::params {

  case $platform {
    'x64': { $plat_filename = 'x64' }
    'x86': { $plat_filename = 'i586' }
    default: { fail("Unsupported platform: ${platform}.  Implement me?") }
   }

   case $::osfamily {
     'RedHat': {
       $newrelic_package_name  = 'newrelic-sysmond'
       $newrelic_service_name  = 'newrelic-sysmond'
       package { 'newrelic-repo-5-3.noarch':
         ensure   => present,
         source   => 'http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm',
         provider => rpm,
       }
     }
     'Debian': {
       $newrelic_package_name  = 'newrelic-sysmond'
       $newrelic_service_name  = 'newrelic-sysmond'
       $newrelic_php_package   = 'newrelic-php5'
       $newrelic_php_service   = 'newrelic-daemon'
     }

     default: {
       fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}")
     }
  }

  if versioncmp('1.9.1', $::rubyversion) > 0 {
    $conf_template = "${module_name}/filebeat.yml.ruby18.erb"
  } else {
    $conf_template = "${module_name}/filebeat.yml.erb"
  }

}
