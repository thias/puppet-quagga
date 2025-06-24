# Class: quagga::params
#
class quagga::params {

  case $facts['os']['name'] {
    'RedHat', 'Fedora', 'CentOS': {
      $package = 'quagga'
    }
    'Gentoo': {
      $package = 'net-misc/quagga'
    }
    default: {
      $package = 'quagga'
    }
  }

}

