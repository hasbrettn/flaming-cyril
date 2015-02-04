require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'
require 'sinatra'
require 'database_cleaner'

SCHEMA_PATH = 'db/schema.rb'
ENV_STAGE = ENV['RACK_ENV']

# 1.) Initialize Logger
$logger = Logger.new(STDERR)
$logger.debug("Loading environment stage: #{ENV_STAGE}")

class NotificationsService < Sinatra::Application

  # 2.) Establish DB Connection
  db_config = YAML::load(File.open('./config/database.yml'))[ENV_STAGE]
  $logger.debug("Attempting to establish connection to database #{db_config['database']}")
  ActiveRecord::Base.establish_connection(db_config)
  ActiveRecord::Base.logger = Logger.new(STDERR) unless ENV_STAGE == 'test'

  # To prevent dealig with mgirations, we just clean the database
  # everytime the server is built. This is obviously not a production solution but is
  # perfect for this demo app.
  load(SCHEMA_PATH) if ENV_STAGE == 'test'
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
  DatabaseCleaner.clean

  # 3.) Load Files
  def self.load_directory!(path)
    Dir[path].each do |file|
      $logger.debug(" ----- Loading #{file}")
      require file
    end
  end

  $logger.debug('Attempting to load the necessary files...')
  load_directory!('./models/**/*.rb')
  load_directory!('./controllers/**/*.rb')
  load_directory!('./apis/**/*.rb')

  # 6.) Define Routes

  # TODO: Flush this out into some sort of route loader
  get '/notifications/find' do
    content_type :json
    Notification.all.to_json
  end

  post '/notification/create' do
    content_type :json

    notification = Notification.from_json(request.body.read)
    if notification.save
      return notification.to_json
    else
      return 403, notification.errors.to_json
    end
  end
end

