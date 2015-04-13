require 'digest'
require 'logger'
require 'sinatra'
require 'sqlite3'

DB_NAME = 'iclas.db'

get '/' do
  erb :index
end

get '/:uuid' do
  erb :form
end

post '/form' do
  uuid = request.referrer.split('/')[-1]
  fields = %w(name, publicName address country telephone apacheId)

  # Get email from pending table
  db = SQLite3::Database.new(DB_NAME)
  # TODO Actually handle if someone provides an incorrect UUID
  email = db.get_first_value "select email from pending where uuid='#{uuid}';"
  icla = File.read(File.join(File.absolute_path(File.dirname(__FILE__)), 'views/icla.md'))

  db.execute <<-SQL
    insert into icla (email, name, preferred_name, address, country, telephone, icla_hash)
    values (
      '#{email}',
      '#{params['name']}',
      '#{params['preferred_name']}',
      '#{params['address']}',
      '#{params['country']}',
      '#{params['telephone']}',
      '#{Digest::MD5.hexdigest(icla)}'
    );
  SQL

  db.execute("delete from pending where uuid='#{uuid}';")
  db.close
  erb :success
end

post '/' do
  error = false
  email = params['email']
  uuid = SecureRandom.uuid
  begin
    SQLite3::Database.new(DB_NAME) do |db|
      db.execute <<-SQL
        insert into pending (uuid, email) values (
          '#{uuid}',
          '#{email}'
        );
      SQL
    end
  rescue SQLite3::ConstraintException
    error = true
  end
  erb :response, locals: { uuid: uuid, error: error }
end

