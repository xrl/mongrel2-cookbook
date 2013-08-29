actions :create, :delete

default_action :create

attribute :server_name, :kind_of => String
attribute :maintenance, :equal_to => [true,false]
attribute :name,        :kind_of => String, :name_attribute => true
attribute :matching,    :kind_of => String