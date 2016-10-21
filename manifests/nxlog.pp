#
# == Class: nxlog
#
# This class installs and configures nxlog.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# Ruben Nieva <ruben.nieva@gmail.com>
#
# === Copyright
#
# Copyright 2016 Ruben Nieva, unless otherwise noted.
#
class sidecar::nxlog {

 case $::hardware{
  'x86_64': {

    case $::osfamily {
      'RedHat': {
        $service_provider = 'redhat'
        case $operatingsystemrelease {
          /^7.*/: {
            $nxlog__package_name = http://nxlog.co/system/files/products/files/1/nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm
          }
          /^6.*/: {
            $nxlog__package_name = http://nxlog.co/system/files/products/files/1/nxlog-ce-2.9.1716-1_rhel6.x86_64.rpm
          }
          default: {
            fail("Unsupported version: ${version}.  Implement me?")
          }
        }
      }

      'Debian': {
        $service_provider = 'debian'
        case $operatingsystemrelease {
          #Ubuntu 16.x
          /^16.*/: {
            $nxlog__package_name  = 'http://nxlog.co/system/files/products/files/1/nxlog-ce_2.9.1716_ubuntu_1604_amd64.deb'
          }
          #Ubuntu 14.x
          /^14.*/: {
            $nxlog__package_name  = 'http://nxlog.co/system/files/products/files/1/nxlog-ce_2.9.1716_ubuntu_1404_amd64.deb'
          }
          #Ubuntu 12.x
          /^12.*/: {
            $nxlog__package_name  = 'http://nxlog.co/system/files/products/files/1/nxlog-ce_2.9.1716_ubuntu_1204_amd64.deb'
          }
          default: {
            fail("Unsupported version: ${version}.  Implement me?")
          }
        }
      }

      default: {
        fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}")
      }

    }
  }

  default: {
    fail("Unsupported osfamily: ${::osfamily} hardware: ${::hardware}")
  }
 }

}
