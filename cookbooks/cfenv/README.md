DESCRIPTION
===========

Sets up ColdFusion 9.0.1 CHF 2 in standalone server mode.

REQUIREMENTS
============

ATTRIBUTES
==========

For ColdFusion
--------------

* `node['cfenv']['install_path']` - ColdFusion installation path (default: "/opt/coldfusion9")
* `node['cfenv']['admin_pw']` - ColdFusion administrator password (default: "cfenv")
* `node['cfenv']['webroot']` - The built in JRun Web Server (JWS) web root (default: "/vagrant/wwwroot") 
  Note: the cookbook will attempt to create this directory if it does not exist.

For SSL
-------

* `node['cfenv']['use_ssl']` - Enable SSL in the JRun config (default: true)
* `node['cfenv']['ssl_keystore_pass']` - Keystore Password (default: "cfenvkeys")
* `node['cfenv']['ssl_hostname']` - Certificate Hostname (default: node['fqdn'])
* `node['cfenv']['ssl_company']` - Certificate Company (default: "CFEnv")
* `node['cfenv']['ssl_country']` - Certificate Country (default: "US")
* `node['cfenv']['ssl_state']` - Certificate State (default: "Pennsylvania")
* `node['cfenv']['ssl_locality']` - Certificate Locality (default: "Philadelphia")
* `node['cfenv']['ssl_ou']` - Certificate OU (default: "CFEnv")
* `node['cfenv']['ssl_email']` - Certificate Email (default: "cfenv@example.com")

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



