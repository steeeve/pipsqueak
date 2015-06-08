require 'sinatra'
require './pip'

post '/pip' do
  label = params['label']
  value = params['value']

  Pip.pip(label, value)
end
