module Hyperfocal
  module Transmitter
    module_function

    def send(type, params)
      url = URI(url_for(type))
      Net::HTTP.post_form(url, params)
    end

    def url_for(type)
      raise 'Unknown Tracking Type' unless %w[ event metric user ].include?(type)

      host = Hyperfocal.host
      return "#{host}/#{type}"
    end
  end
end
