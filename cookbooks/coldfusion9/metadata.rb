maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "goettnel@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs/Configures ColdFusion 9.0.1"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

%w{ ubuntu }.each do |os|
  supports os
end

depends "unzip"

recipe "coldfusion9", "Includes the standalone recipe"
recipe "coldfusion9::chf9010002", "Downloads and installs ColdFusion 9.0.1 : Cumulative Hot fix 2 (http://kb2.adobe.com/cps/918/cpsid_91836.html)"
recipe "coldfusion9::datasources", "Configures ColdFusion datasources"
recipe "coldfusion9::hf90100003", "Downloads and installs ColdFusion Security Hotfix (http://kb2.adobe.com/cps/925/cpsid_92512.html)"
recipe "coldfusion9::ssl", "Configures SSL support for the built in JRun web server"
recipe "coldfusion9::standalone", "Installs ColdFusion 9.0.1 in standalone mode."


