actions :create, :destroy

attribute :host,          :kind_of => String
attribute :base,          :kind_of => String
attribute :index_file,    :kind_of => String
attribute :default_ctype, :kind_of => String
attribute :cache_ttl,     :kind_of => Fixnum
