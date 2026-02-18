# Class: quagga
#
# Quagga routing server.
#
# Parameters:
#  $ospfd_content:
#    Content (typically using a template) for the ospfd.conf file.
#  $ospfd_source:
#    Source location for the ospfd.conf file.
#
# Sample Usage :
#  class { 'quagga':
#    ospfd_content => template('mymodule/quagga/ospfd.conf.erb'),
#  }
#
class quagga (
  $ospfd_content = undef,
  $ospfd_source  = undef,
) inherits ::quagga::params {

  package { $::quagga::params::package:
    ensure => 'installed',
    alias  => 'quagga',
  }
  # The service refuses to start without this file (missing on Gentoo)
  -> exec { 'create-initial-zebra.conf':
    command => "/bin/echo \"hostname ${facts['networking']['hostname']}\" > /etc/quagga/zebra.conf",
    creates => '/etc/quagga/zebra.conf',
  }
  -> service { 'zebra':
    ensure => 'running',
    enable => true,
  }

  # Included protocol-specific services :
  # bgpd
  # ospf6d
  # ospfd
  # ripd
  # ripngd

  if $ospfd_content or $ospfd_source {
    service { 'ospfd':
      ensure  => 'running',
      enable  => true,
      require => [ Service['zebra'], File['/etc/quagga/ospfd.conf'] ],
    }
    file { '/etc/quagga/ospfd.conf':
      content => $ospfd_content,
      source  => $ospfd_source,
      require => Package['quagga'],
      notify  => Service['ospfd'],
    }
  } else {
    service { 'ospfd':
      ensure  => 'stopped',
      enable  => false,
      require => Package['quagga'],
    }
    file { '/etc/quagga/ospfd.conf': ensure => 'absent' }
  }

}

