# puppet-quagga

## Overview

Install, enable and configure the Quagga suite, for dynamic network routing
protocols such as RIP, OSPF and BGP.
This module is in early stage and only supports OSPF at this point. Adding the
other protocols should be very easy.

* `quagga` : Class to install and enable the server

## Examples

    $ospf_router_id = $mymodule::vpn::vars::ipaddress[$::fqdn]
    class { 'quagga':
      ospfd_content => template('mymodule/quagga/ospfd.conf.erb'),
    }

