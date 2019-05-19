require 'webmock/rspec'
require 'faker'
require 'factory_bot'

ENV['STAGE'] = 'test'

require Dir.pwd + '/config.rb'
Dir['./spec/factories/*.rb'].each { |file| require file }

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  #workaround for database cleanup
  config.before(:each) do
    CampaignRepository.new.clear
  end
end
