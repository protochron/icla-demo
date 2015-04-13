require 'sqlite3'

task :bootstrap do
  puts `npm install`
  puts `bower install --allow-root`
  puts `jsx jsx public/js`
end

task :initialize_db do
  unless File.exist?('iclas.db')
    db = SQLite3::Database.new('iclas.db')

    db.execute <<-SQL
    create table pending (
      uuid text primary key,
      email varchar unique
    );
    SQL

    db.execute <<-SQL
      create table icla (
        id integer primary key autoincrement,
        email varchar unique,
        name varchar,
        preferred_name varchar,
        address text,
        country varchar,
        telephone varchar,
        icla_hash varchar
        signed timestamp default (strftime('%s', 'now')),
      );
    SQL
  end
end
