DESCRIPTION
===========

Sets up ColdFusion 9.0.1 CHF 2. Currently supports standalone server on 32bit Linux.

REQUIREMENTS
============

ATTRIBUTES
==========

For ColdFusion
--------------

* `node['cf9']['install_path']` - ColdFusion installation path (default: "/opt/coldfusion9")
* `node['cf9']['admin_pw']` - ColdFusion administrator password (default: "vagrant")
* `node['cf9']['webroot']` - The built in JRun Web Server (JWS) web root (default: "/vagrant/wwwroot") 
  Note: the cookbook will attempt to create this directory if it does not exist.

For SSL
-------

* `node['cf9']['ssl_keystore_pass']` - Keystore Password (default: "cf9keys")
* `node['cf9']['ssl_hostname']` - Certificate Hostname (default: node['fqdn'])
* `node['cf9']['ssl_company']` - Certificate Company (default: "ColdFuison")
* `node['cf9']['ssl_country']` - Certificate Country (default: "US")
* `node['cf9']['ssl_state']` - Certificate State (default: "Pennsylvania")
* `node['cf9']['ssl_locality']` - Certificate Locality (default: "Philadelphia")
* `node['cf9']['ssl_ou']` - Certificate OU (default: "ColdFuison")
* `node['cf9']['ssl_email']` - Certificate Email (default: "coldfuison9@example.com")

For Datasources
---------------

* `node['cf9']['datasources']` - A struct of datasources (default: {})

Below is a sample JSON datasource definition:

    "datasources" => {
      "some_db" => {
        "name" => "SOME_DB",
        "driver" => "MSSQLServer",
        "vender" => "sqlserver",
        "buffer" => "128000.0",
        "jdbc_class" => "jdbc:macromedia:sqlserver",
        "server_address" => "dbserver.example.edu",
        "server_port" => "1433",
        "db_name" => "SOME_DB"
      }
    }

For Trusted Certificates
------------------------

* `node['cf9']['trustedcerts']` - A struct of trusted certificates (default: {})

The struct should contain a key, which will be used as the alias when importing the cert
into the cacerts keystore. The value of the key should be the name of a certificate file
found in the cookbook files. Below is a sample JSON trustedcerts definition:

    "trustedcerts" => {
      "mycert" => "mycert.cer"
      }
    }


