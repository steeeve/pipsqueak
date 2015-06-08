require 'sinatra'
require './pip'

post '/pip' do
  label = params['label']
  value = params['value']

  Pip.pip(label, value)
end

get '/pips' do
  from = params['from']
  to = params['to']

  pips = Pip.find(from, to)

  pips.to_json
end
