DESCRIPTION
===========

Sets up ColdFusion 9.0.1 CHF 2. Currently supports standalone server on 32bit Linux.

REQUIREMENTS
============

ATTRIBUTES
==========

For ColdFusion
--------------

* `node['cfenv']['install_path']` - ColdFusion installation path (default: "/opt/coldfusion9")
* `node['cfenv']['admin_pw']` - ColdFusion administrator password (default: "vagrant")
* `node['cfenv']['webroot']` - The built in JRun Web Server (JWS) web root (default: "/vagrant/wwwroot") 
  Note: the cookbook will attempt to create this directory if it does not exist.

For SSL
-------

* `node['cfenv']['ssl_keystore_pass']` - Keystore Password (default: "cf9keys")
* `node['cfenv']['ssl_hostname']` - Certificate Hostname (default: node['fqdn'])
* `node['cfenv']['ssl_company']` - Certificate Company (default: "ColdFuison")
* `node['cfenv']['ssl_country']` - Certificate Country (default: "US")
* `node['cfenv']['ssl_state']` - Certificate State (default: "Pennsylvania")
* `node['cfenv']['ssl_locality']` - Certificate Locality (default: "Philadelphia")
* `node['cfenv']['ssl_ou']` - Certificate OU (default: "ColdFuison")
* `node['cfenv']['ssl_email']` - Certificate Email (default: "coldfuison9@example.com")

For Datasources
---------------

* `node['cfenv']['datasources']` - A struct of datasources (default: {})

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

* `node['cfenv']['trustedcerts']` - A struct of trusted certificates (default: {})

The struct should contain a key, which will be used as the alias when importing the cert
into the cacerts keystore. The value of the key should be the name of a certificate file
found in the cookbook files. Below is a sample JSON trustedcerts definition:

    "trustedcerts" => {
      "mycert" => "mycert.cer"
      }
    }


