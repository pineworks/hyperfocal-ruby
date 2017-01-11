module Hyperfocal
  module Transmitter
    module_function

    def send(type, params)
      if Hyperfocal.configuration.environments.include?(Hyperfocal.configuration.env)
        url = URI(url_for(type))
        params.merge!(environment: Hyperfocal.configuration.env)
        Net::HTTP.post_form(url, params)
      else
        Hyperfocal.logger.info "Logging #{type} params: #{params}"
      end
    end

    def url_for(type)
      raise 'Unknown Tracking Type' unless %w[ event metric user ].include?(type)

      host = Hyperfocal.host
      return "#{host}/#{type}"
    end
  end
end
