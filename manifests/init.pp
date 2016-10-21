#
# == Class: sidecar
#
# This class installs and configures Graylog Sidecar collector.
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
class (
  $filebeat   = false,
  $nxlog      = false
){

if $nxlog {

  exec { 'Install nxlog':
    command => "wget --no-check-certificate -O ${jar_file} ${source}/${jar_file}",
    cwd     => $aem_install,
    user    => $user,
    group   => $user,
    path    => ['/bin','/usr/bin','/usr/local/bin'],
    creates => "${aem_install}/${jar_file}",
    timeout => 1200,
  }

  exec { "accept_java_license for ${jar_file}":
    command => 'echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections \
                && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections',
    unless  => 'dpkg -l | grep oracle-java8-installer',
    path    => '/bin:/usr/bin',
  }


}
