maintainer       "Thomas Rampelberg"
maintainer_email "thomas@saunter.org"
license          "Apache 2.0"
description      "Installs/Configures mongrel2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.5"

%w( git build-essential zeromq ).each do |cookbook|
  depends cookbook
end