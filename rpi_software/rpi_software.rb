require 'sinatra/base'
require 'lib/test_led'

class RpiSoftwareApp < Sinatra::Base
  get '/hi' do
    'leeeeooooooon leeeeeeeeooooon'
  end

  get 'test_led/:pin' do
    TestLed.call(params[:pin])
  end
end
