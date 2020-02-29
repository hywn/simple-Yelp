require 'json'
require 'net/http'


API_KEY = ENV['YELP_KEY']

API_HOST         =            'https://api.yelp.com/v3/'
URL_SEARCH       = API_HOST + 'businesses/search'
URL_BUSINESS     = API_HOST + 'businesses/'  # trailing / because we append the business id to the path
URL_AUTOCOMPLETE = API_HOST + 'autocomplete'


# submit query to yelp API
# returns nil if timed out
def query(url, params={})
	uri = URI(url)
	uri.query = URI.encode_www_form(params)
	
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.open_timeout = 2
	
	begin
		response = http.get(uri, headers={ Authorization: "Bearer #{API_KEY}" })
	rescue
		return nil
	end
	
	JSON.parse(response.body)
end


### Yelp API wrappers ###

def yelp_business(business_id)
	query(URL_BUSINESS + business_id)
end

def yelp_search(text, latitude, longitude)
	query(URL_SEARCH,
		term: text,
		latitude: latitude,
		longitude: longitude,
		categories: 'restaurants,food,bars'
	)
end

def yelp_autocomplete(text, latitude, longitude)
	query(URL_AUTOCOMPLETE,
		text: text,
		latitude: latitude,
		longitude: longitude
	)
end