actions :create, :destroy

default_action :create

attribute :id
attribute :send_spec,   :kind_of => String
attribute :send_ident,  :kind_of => String
attribute :recv_spec,   :kind_of => String
attribute :recv_ident,  :kind_of => String
attribute :raw_payload, :kind_of => Fixnum
attribute :protocol,    :equal_to => [:json], :default => :json


# CREATE TABLE handler (id INTEGER PRIMARY KEY,
#     send_spec TEXT,
#     send_ident TEXT,
#     recv_spec TEXT,
#     recv_ident TEXT,
#    raw_payload INTEGER DEFAULT 0,
#    protocol TEXT DEFAULT 'json');