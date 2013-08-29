action :create do
  require 'set'
  require 'sequel'

  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    existing = db[:route].\
                  join(:directory, :route__target_id => :directory__id, :route__target_type=>"dir").\
                  filter(:directory__base => @new_resource.base).\
                  filter(:route__path => @new_resource.name)
    next if existing.count > 0

    host = db[:host].filter(:name => @new_resource.host).first
    raise ArgumentError, "no host '#{@new_resource.host}'" if host.nil?
    host_id = host[:id]

    handler = {}
    handler[:base]          = @new_resource.base
    handler[:index_file]    = @new_resource.index_file
    handler[:default_ctype] = @new_resource.default_ctype
    handler[:cache_ttl]     = @new_resource.cache_ttl

    handler_id = db[:directory].insert(handler)

    route = {:host_id     => host_id,
             :path        => @new_resource.name,
             :target_id   => handler_id,
             :target_type => "dir"}

    route_id = db[:route].insert(route)
  end
end

action :destroy do
  require 'sequel'
  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    db[:route].\
      join(:directory, :route__target_id => :directory__id, :route__target_type=>"dir").\
      filter(:directory__base => @new_resource.base).\
      filter(:route__path => @new_resource.name).delete
  end
end