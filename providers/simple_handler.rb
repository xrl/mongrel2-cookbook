action :create do
  require 'set'
  require 'sequel'

  def allocate_local_port(db, skip = [])
    specs = skip
    db[:handler].select(:send_spec,:recv_spec).all.each{|sp| specs << sp[:send_spec]; specs << sp[:recv_spec]}
    port_set = Set.new specs.collect{|sp| URI::parse(sp).port }

    new_port = 5000
    while(port_set.include?(new_port)) do
      new_port += 1
    end
    new_port
  end

  def new_tcp_spec(db, skip = [])
    "tcp://localhost:#{allocate_local_port(db, skip)}"
  end

  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    next if db[:handler].filter(:send_ident => @new_resource.send_ident,
                                  :recv_ident => @new_resource.recv_ident).count == 1
    host = db[:host].filter(:name => @new_resource.host).first
    raise ArgumentError, "no host '#{@new_resource.host}'" if host.nil?
    host_id = host[:id]

    handler = {}
    handler[:send_spec]  = new_tcp_spec(db)
    handler[:send_ident] = @new_resource.send_ident
    handler[:recv_spec]  = new_tcp_spec(db, [handler[:send_spec]])
    handler[:recv_ident] = @new_resource.recv_ident

    handler_id = db[:handler].insert(handler)

    route = {:host_id => host_id,
             :path => @new_resource.name,
             :target_id => handler_id,
             :target_type => "handler"}

    route_id = db[:route].insert(route)
  end
end

action :destroy do
  require 'sequel'
  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    db[:route].\
      join(:handler, :route__target_id => :handler__id, :route__target_type=>"handler").\
      filter(:handler__send_ident => @new_resource.send_ident).\
      filter(:handler__recv_ident => @new_resource.recv_ident).\
      filter(:route__path => @new_resource.name).delete
  end
end