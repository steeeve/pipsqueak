require 'sinatra'
require './stat'

post '/pip' do
  label = params['label']
  value = params['value']

  Stat.pip(label, value)
end
