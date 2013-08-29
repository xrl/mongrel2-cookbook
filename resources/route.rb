# Forgotten for now to make things simpler

actions :create, :destroy

default_action :create

attribute :id
attribute :path,      :kind_of => String, :name_attribute => true
attribute :reversed,  :kind_of => TrueClass, :default => false
attribute :host_id,   :kind_of => Fixnum
attribute :target_id, :kind_of => Fixnum
attribute :target_type, :equal_to => [:handler,:proxy,:dir]