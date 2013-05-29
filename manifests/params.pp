# Class: quagga::params
#
class quagga::params {

  case $::operatingsystem {
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

