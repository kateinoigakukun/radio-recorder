require 'bundler'
Bundler.require
Dir[File.expand_path("../app/*.rb", __FILE__)].each {|file| require_relative file }

config = YAML.load_file(File.expand_path('../config/config.yml', __FILE__))
schedule_list = config['schedule']
secret = YAML.load_file(File.expand_path('../config/secret.yml', __FILE__))
token = secret['slack_token']
Slack.configure do |conf|
  conf.token = token
end
output  = config['config']['output']
r = Recorder.new schedule_list[1]
r.record output

