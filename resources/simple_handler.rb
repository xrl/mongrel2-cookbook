actions :create, :destroy

default_action :create

attribute :id
attribute :send_spec,   :kind_of => String, :default => lambda{|x| raise "hi" }
attribute :send_ident,  :kind_of => String
attribute :recv_spec,   :kind_of => String
attribute :recv_ident,  :kind_of => String
attribute :raw_payload, :kind_of => Fixnum
attribute :protocol,    :equal_to => [:json], :default => :json

attribute :path, :kind_of => String
attribute :host, :kind_of => String