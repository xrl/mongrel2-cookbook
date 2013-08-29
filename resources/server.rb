actions :create, :update

default_action :create

attribute :default_host, :kind_of => String, :name_attribute => true
attribute :uuid,         :kind_of => String
attribute :access_log,   :kind_of => String
attribute :error_log,    :kind_of => String
attribute :chroot,       :kind_of => String, :default => '/var/www'
attribute :pid_file,     :kind_of => String
attribute :name,         :kind_of => String, :default => ''
attribute :bind_addr,    :kind_of => String, :default => '0.0.0.0'
attribute :port,         :kind_of => Fixnum
attribute :use_ssl,      :equal_to => [true,false], :default => false

# CREATE TABLE server (id INTEGER PRIMARY KEY,
#     uuid TEXT,
#     access_log TEXT,
#     error_log TEXT,
#     chroot TEXT DEFAULT '/var/www',
#     pid_file TEXT,
#     default_host TEXT,
#     name TEXT DEFAULT '',
#     bind_addr TEXT DEFAULT "0.0.0.0",
#     port INTEGER,
#     use_ssl INTEGER default 0);