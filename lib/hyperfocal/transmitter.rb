require 'typhoeus'

module Hyperfocal
  module Transmitter
    module_function

    def send(type, params)
      if send_event
        url = URI(url_for(type))
        params.merge!(environment: Hyperfocal.configuration.env)
        Typhoeus.post(url, body: params)
      else
        Hyperfocal.logger.info "Logging #{type} params: #{params}"
      end
    end

    def url_for(type)
      raise 'Unknown Tracking Type' unless %w[ event metric ].include?(type)

      host = Hyperfocal.host
      return "#{host}/#{type}"
    end

    def send_event
      return true if Hyperfocal.configuration.env.nil?
      Hyperfocal.configuration.environments.include?(Hyperfocal.configuration.env)
    end
  end
end
