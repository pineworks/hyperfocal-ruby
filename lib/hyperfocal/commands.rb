require 'hyperfocal'
require 'net/http'
require 'thor'
require 'json'

module Hyperfocal
  class Commands < Thor
    desc :setup, 'Set up Hyperfocal'
    def setup(token=nil)
      return say('A token is required. Please visit http://hyperfocal.io to get a setup token', :red) if token.nil?
      return say('Invalid app token, please make sure you have it correct', :red) unless valid_token?(token)

      if File.exists?(initializer_path)
        say('Initializer already exists', :red)
        say('You can view your app at http://hyperfocal.io or remove config/initializers/hyperfocal.rb and set it up as a new app', :red)
      else
        write_initializer(token)
        activate_app(token)
        say('Congratulations, your app is ready to send events to Hyperfocal', :green)
      end
    end

    desc :uninstall, 'Uninstall Hyperfocal'
    def uninstall
      if File.exists?(initializer_path)
        File.delete(initializer_path)
        say('The Hyperfocal initializer has been removed.')
        say('Removing the gem from your Gemfile, and code from your app will complete the installation')
        say("We're sad to see you go, if there's anything we can do, drop us a line at support@hyperfocal.io")
      else
        say('Hyperfocal does not have a configuration file, there is nothing to uninstall', :red)
      end
    end

    private

    def initializer_path
      File.expand_path(relative_initializer_path)
    end

    def relative_initializer_path
      'config/initializers/hyperfocal.rb'
    end

    def write_initializer(token)
      FileUtils.mkdir_p(File.dirname(initializer_path))

      File.open(initializer_path, 'w') do |f|
        f.puts <<-CONF
Hyperfocal.configure do |config|
  config.app_id = #{token}
end
        CONF
      end
    end

    def activate_app(token)
      uri = URI('http://api.hyperfocal.io/activate')
      req = Net::HTTP.post_form(uri, { token: token })
    end

    def valid_token?(token)
      req = Net::HTTP.get("api.hyperfocal.io", "/validate?token=#{token}")
      return JSON.parse(req.to_s)['valid']
    end
  end
end

