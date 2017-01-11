require "yaml"
require "hyperfocal/version"
require "hyperfocal/transmitter"

module Hyperfocal
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def host
      raise 'App ID Not Set' if configuration.app_id.nil?

      configuration.host + '/track/' + configuration.app_id
    end

    def event(event, attrs = {})
      send_request do
        event_params = { event: attrs.merge(title: event) }
        Transmitter.send('event', event_params)
      end
    end

    def metric(metric, value, attrs = {})
      send_request do
        metric_params = { metric: attrs.merge(title: metric, value: value) }
        Transmitter.send('metric', metric_params)
      end
    end

    def user(attrs)
      send_request do
        user_params = { user: attrs }
        Transmitter.send('user', user_params)
      end
    end

    def send_request(&block)
      thr = Thread.new do
        yield
      end
      thr.join
      thr.exit
    end

    def logger
      Logger.new(STDOUT)
    end
  end

  class Configuration
    attr_accessor :app_id
    attr_accessor :environments
    attr_reader   :env
    attr_reader   :host

    def initialize
      @env = (ENV['RAILS_ENV'] || ENV['RACK_ENV'])
      @host = 'https://api.hyperfocal.io'.freeze
      @environments = %w[ production ].freeze
    end
  end
end
