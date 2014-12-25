require 'events/version'
require 'httparty'

module Events
  CONFIG_FILE_NAME = 'events.yml'
  DEFAULT_HOST = 'http://127.0.0.1:9292'

  def self.notify(event, data={})
    HTTParty.post("#{host}/event", query: {
        event: event,
        data: data
    })
  end

  private

  def self.host
    @host ||= load_host
  end

  def self.load_host
    config_path = Rails.root.join('config', CONFIG_FILE_NAME).to_s
    if File.exist?(config_path)
      config = YAML.load(File.read(config_path))
      config['host']
    else
      DEFAULT_HOST
    end
  end
end
