require 'logger'
require 'sinatra'
require 'sqlite3'

DB_NAME = 'iclas.db'

get '/' do
  erb :index
end

get '/:uuid' do
  uuid = params['uuid']
  db = SQLite3::Database.new(DB_NAME)
  # TODO Actually handle if someone provides an incorrect UUID
  email = db.get_first_value "select email from pending where uuid='#{uuid}';"
  erb :form
end

post '/' do
  email = params['email']
  uuid = SecureRandom.uuid
  SQLite3::Database.new(DB_NAME) do |db|
    db.execute <<-SQL
      insert into pending (uuid, email) values (
        '#{uuid}',
        '#{email}'
      );
    SQL
  end
  erb :response, locals: { uuid: uuid }
end

