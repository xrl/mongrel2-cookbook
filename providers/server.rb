keys = %w(name uuid access_log error_log chroot pid_file bind_addr port)

action :create do
  require 'sequel'
  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"
  Sequel.connect sqlite_db do |db|
    entry = keys.inject({}){|hash,key| hash[key] = @new_resource.send(key); hash }
    raise entry.inspect
    entry[:use_ssl] = @new_resource.use_ssl ? '1' : '0'
    if db[:server].where(:uuid => @new_resource.uuid).count == 0
      db[:server] << entry
    else
      db[:server].where(:uuid => @new_resource.uuid).update(entry)
    end
  end
end

action :delete do
  require 'sequel'
  sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

  Sequel.connect sqlite_db do |db|
    db[:server].where(:uuid => @new_resource.uuid).delete
    # TODO: cascade deletes to host and on down
  end
end