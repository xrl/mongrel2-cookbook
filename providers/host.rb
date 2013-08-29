# [[:id, "INTEGER"], [:server_id, "INTEGER"],
#  [:maintenance, "BOOLEAN"], [:name, "TEXT"],
#  [:matching, "TEXT"]]

keys = %w(maintenance name matching)

action :create do
  require 'sequel'
  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    server = db[:server].where(:name => @new_resource.server_name).first
    if server.nil?
      servers = db[:server].all.collect{|s| s[:name] }
      raise RuntimeError, "could not find server #{@new_resource.server_name}. How about one of #{servers.join(', ')}?"
    end

    entry = keys.inject({}){|hash,key| hash[key] = @new_resource.send(key); hash }
    entry["server_id"] = server[:id]

    if db[:host].where(:name => @new_resource.name).count == 0
      db[:host] << entry
    else
      db[:host].where(:name => @new_resource.name).update(entry)
    end

  end
end

action :delete do
  require 'sequel'
  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    db[:host].where(:name => @new_resource.name).delete
  end
end