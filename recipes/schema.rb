ruby "setup mongrel2 config database" do

  code <<-EOH
    require 'sequel'
    sqlite_db = "sqlite:///home/mongrel2/etc/mongrel2.sqlite"

    Sequel.connect(sqlite_db) do |db|
      # From a mongrel2 db
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
      # What sequel generates
      # CREATE TABLE `server` (`id` integer NOT NULL PRIMARY KEY AUTOINCREMENT, `uuid` text, `access_log` text, `error_log` text, `chroot` text DEFAULT ('/var/www'), `pid_file` text, `default_host` text, `name` text DEFAULT (''), `bind_addr` text DEFAULT ('0.0.0.0'), `port` integer, `use_ssl` boolean DEFAULT ('f'));
      db.create_table :server do
        primary_key :id
        text :uuid
        text :access_log
        text :error_log
        text :chroot, :default => "/var/www"
        text :pid_file
        text :default_host
        text :name, :default => ""
        text :bind_addr, :default => "0.0.0.0"
        integer :port
        integer :use_ssl, :default => 0
      end unless db.table_exists?(:server)

      # CREATE TABLE host (id INTEGER PRIMARY KEY,
      #     server_id INTEGER,
      #     maintenance BOOLEAN DEFAULT 0,
      #     name TEXT,
      #     matching TEXT);
      # From Sequel:
      # CREATE TABLE `host` (`id` integer NOT NULL PRIMARY KEY AUTOINCREMENT, `server_id` integer, `maintenance` boolean DEFAULT ('f'), `name` text, `matching` text);
      db.create_table :host do
        primary_key :id
        integer :server_id
        boolean :maintenance, :default => 0
        text :name
        text :matching
      end unless db.table_exists?(:host)

      # CREATE TABLE route (id INTEGER PRIMARY KEY,
      #     path TEXT,
      #     reversed BOOLEAN DEFAULT 0,
      #     host_id INTEGER,
      #     target_id INTEGER,
      #     target_type TEXT);
      # From Sequel:
      db.create_table :route do
        primary_key :id
        text :path
        boolean :reversed, :default => 0
        integer :host_id
        integer :target_id
        text :target_type
      end unless db.table_exists?(:route)

      # CREATE TABLE directory (id INTEGER PRIMARY KEY,
      #     base TEXT,
      #     index_file TEXT,
      #     default_ctype TEXT,
      #     cache_ttl INTEGER DEFAULT 0);
      # From sequel:
      db.create_table :directory do
        primary_key :id
        text :base
        text :index_file
        text :default_ctype
        integer :cache_ttl, :default => 0
      end unless db.table_exists?(:directory)

      # CREATE TABLE handler (id INTEGER PRIMARY KEY,
      #     send_spec TEXT,
      #     send_ident TEXT,
      #     recv_spec TEXT,
      #     recv_ident TEXT,
      #    raw_payload INTEGER DEFAULT 0,
      #    protocol TEXT DEFAULT 'json');
      # From sequel:
      db.create_table :handler do
        primary_key :id
        text :send_spec
        text :send_ident
        text :recv_spec
        text :recv_ident
        integer :raw_payload, :default => 0
        text :protocol, :default => "json"
      end unless db.table_exists?(:handler)

      # CREATE TABLE proxy (id INTEGER PRIMARY KEY,
      #     addr TEXT,
      #     port INTEGER);
      db.create_table :proxy do
        primary_key :id
        text :addr
        integer :port
      end unless db.table_exists?(:proxy)

      # CREATE TABLE log(id INTEGER PRIMARY KEY,
      #     who TEXT,
      #     what TEXT,
      #     location TEXT,
      #     happened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      #     how TEXT,
      #     why TEXT);
      db.create_table :log do
        primary_key :id
        text :who
        text :what
        text :location
        # TODO: How can I make this 'CURRENT_TIMESTAMP'?
        timestamp :happened_at
        text :how
        text :why
      end unless db.table_exists?(:log)

      # CREATE TABLE statistic (id SERIAL,
      #   other_type TEXT,
      #   other_id INTEGER,
      #   name TEXT,
      #   sum REAL,
      #   sumsq REAL,
      #   n INTEGER,
      #   min REAL,
      #   max REAL,
      #   mean REAL,
      #   sd REAL,
      #   primary key (other_type, other_id, name));
      db.create_table :statistic do
        serial :id
        text :other_type
        integer :other_id
        text :name
        real :sum
        real :sumsq
        integer :n
        real :min
        real :max
        real :mean
        real :sd
        primary_key [:other_type, :other_id, :name]
      end unless db.table_exists?(:statistic)

      # CREATE TABLE filter (id INTEGER PRIMARY KEY,
      #   server_id INTEGER,
      #   name TEXT,
      #   settings TEXT);
      db.create_table :filter do
        primary_key :id
        integer :server_id
        text :name
        text :settings
      end unless db.table_exists?(:filter)

      # CREATE TABLE mimetype (id INTEGER PRIMARY KEY, mimetype TEXT, extension TEXT);
      db.create_table :mimetype do
        primary_key :id
        text :mimetype
        text :extension
      end unless db.table_exists?(:mimetype)

      # CREATE TABLE setting (id INTEGER PRIMARY KEY, key TEXT, value TEXT);
      db.create_table :setting do
        primary_key :id
        text :key
        text :value
      end unless db.table_exists?(:setting)

      # CREATE TABLE xrequest (id INTEGER PRIMARY KEY,
      #     server_id INTEGER,
      #     name TEXT,
      #     settings TEXT);
      db.create_table :xrequest do
        primary_key :id
        integer :server_id
        text :name
        text :settings
      end unless db.table_exists?(:xrequest)

    end
  EOH
end