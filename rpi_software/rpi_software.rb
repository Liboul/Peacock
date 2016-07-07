require 'sinatra/base'
require 'sinatra/param'
require './lib/test_led'
require './lib/program_factory'

class RpiSoftwareApp < Sinatra::Base
  helpers Sinatra::Param

  ## Test routes
  get '/hi' do
    'leeeeooooooon leeeeeeeeooooon'
  end

  get '/test_led/:pin' do
    TestLed.call(params[:pin])
    'yo'
  end

  get '/hoy' do
    param :name, String, required: true
    "Hello #{params[:name]}"
  end

  ## True routes
  get '/instruct' do
    param :instructions, Hash, required: true
    ProgramFactory.call(params[:instructions])
  end
end
