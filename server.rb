require 'sinatra'
require 'sinatra/cross_origin'
register Sinatra::CrossOrigin
load 'my_api.rb'


# not sure if this even affects anything
set :threaded, true


### serves simple-Yelp API functions ###

get '/search' do
	cross_origin
	
	my_search params[:input], params[:latitude], params[:longitude]
end

get '/autocomplete' do
	cross_origin
	
	my_autocomplete params[:input], params[:latitude], params[:longitude]
end