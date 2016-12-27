require 'spec_helper'

describe Hyperfocal::Transmitter do
  let(:host) { 'https://api.hyperfocal.io/track/test/' }

  before :all do
    Hyperfocal.configure do |config|
      config.app_id = 'test'
    end
  end

  after :all do
    Hyperfocal.configuration = Hyperfocal::Configuration.new
  end

  describe '#url_for' do
    it 'returns the proper URLs for tracking' do
      types = %w[ event user metric ]
      types.each do |type|
        expect(described_class.url_for(type)).to eq host + type
      end
    end

    it 'raises and error for unknown types' do
      expect {described_class.url_for('potato')}.to raise_error
    end
  end

  describe '#send' do
    it 'sends events to the proper endpoint' do
      params = { event: { title: 'Event', user_id: 5, name: 'Bob' }}
      url = 'https://api.hyperfocal.io/track/test/event'
      test_type('event', url, params)
    end

    it 'sends metrics to the proper endpoint' do
      params = { metric: { title: 'Metric', value: 5, time: Time.now }}
      url = 'https://api.hyperfocal.io/track/test/metric'
      test_type('metric', url, params)
    end

    it 'sends users to the proper endpoint' do
      params = { user: { uid: 'bobo', email: 'hello@example.com', age: 20, }}
      url = 'https://api.hyperfocal.io/track/test/user'
      test_type('user', url, params)
    end
  end

  def test_type(type, url, params)
    body = URI.encode_www_form(params)
    stub = stub_request(:post, url)

    described_class.send(type, params)
    expect(a_request(:post, url)).to have_been_made
    expect(described_class).to have_requested(:post, url).with(body: body)
  end
end
