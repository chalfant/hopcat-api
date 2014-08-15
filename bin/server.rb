#!/usr/bin/env ruby
require 'sinatra'
require 'hopcat/api'
require 'json'

get '/drafts' do
  d = Hopcat::Api::Draft.new
  JSON.generate(d.list)
end
