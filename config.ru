lib = File.expand_path("./", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


require './app/api/base'

run Api::Base

Sinatra::Application.set :view, `pwd` + 'view'
