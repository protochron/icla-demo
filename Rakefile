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
      email varchar
    );
    SQL

    db.execute <<-SQL
      create table icla (
        id integer primary key autoincrement,
        email varchar,
        name varchar,
        preferred_name varchar,
        addresss text,
        telephone varchar,
        signed datetime
      );
    SQL
  end
end
