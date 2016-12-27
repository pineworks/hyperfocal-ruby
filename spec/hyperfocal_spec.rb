require "spec_helper"

describe Hyperfocal do
  before :all do
    Hyperfocal.configure do
    end
  end

  it "has a version number" do
    expect(Hyperfocal::VERSION).not_to be nil
  end

  it "Errors when no App ID is provided" do
    expect{ Hyperfocal.host }.to raise_error
  end

  it "Sets the host with the App ID" do
    Hyperfocal.configuration.app_id = 'test'
    expect(Hyperfocal.host).to eq 'https://api.hyperfocal.io/track/test'
  end

  describe 'api tracking' do
    before :each do
      Hyperfocal.configure do |config|
        config.app_id = 'test'
      end
    end

    after :all do
      Hyperfocal.configure do
      end
    end

    it 'tracks events to the api' do
      url = 'https://api.hyperfocal.io/track/test/event'
      stub = stub_request(:post, url)

      Hyperfocal.event('Sign In', user_id: 5, another: 'thing')

      body = URI.encode_www_form({ event: { user_id: 5, another: 'thing', title: 'Sign In'}})
      expect(a_request(:post, url)).to have_been_made
      expect(described_class).to have_requested(:post, url).with(body: body)
    end

    it 'tracks metrics to the api' do
      url = 'https://api.hyperfocal.io/track/test/metric'
      stub = stub_request(:post, url)

      Hyperfocal.metric('New Users', 7, another: 'thing')

      body = URI.encode_www_form({ metric: { another: 'thing', title: 'New Users', value: 7}})
      expect(a_request(:post, url)).to have_been_made
      expect(described_class).to have_requested(:post, url).with(body: body)
    end

    it 'tracks users to the api' do
      url = 'https://api.hyperfocal.io/track/test/user'
      stub = stub_request(:post, url)

      Hyperfocal.user(name: 'Bob', email: 'hi@example.com')

      body = URI.encode_www_form({ user: { name: 'Bob', email: 'hi@example.com' }})
      expect(a_request(:post, url)).to have_been_made
      expect(described_class).to have_requested(:post, url).with(body: body)
    end

    def test_tracking(type, url, exprected_body)
      body = URI.encode_www_form(params)
      stub = stub_request(:post, url)
    end
  end
end
