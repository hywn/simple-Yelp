require 'json'
load 'yelp_api.rb'


### API functions designed to interface with the simple-Yelp site ###

# returns a single, predicted search term based on user input
# to be called repeatedly
def my_autocomplete(input, latitude, longitude)
	yelp = yelp_autocomplete(input, latitude, longitude)
	
	return '"error"' if yelp.nil? || yelp['error']
	
	prediction = (
		yelp['categories'].map{ |category| category['title'] } +
		yelp['terms'].map{ |term| term['text'] }
	)  .map { |x| x.downcase }
	.select { |x| x.start_with? input.downcase }
	   .map { |x| x[0...x.index(/[^a-z]/, input.length)] }
	   .min { |a, b| a.length <=> b.length }
	
	JSON.generate({ prediction: prediction }) # return a hash to differentiate {prediction:"error"} from simply "error"
end

# returns a list of businesses based on user input
# to be called occasionally with complete terms, viz. those from my_autocomplete()
def my_search(input, latitude, longitude)
	yelp = yelp_search(input, latitude, longitude)
	
	return '"error"' if yelp.nil? || yelp['error']
	
	results = yelp['businesses'].map do |business|
		{
			name:      business['name'],
			id:        business['id'],
			url:       business['url'],
			rating:    business['rating'],
			price:     business['price'],
			distance:  business['distance'],
			latitude:  business['coordinates']['latitude'],
			longitude: business['coordinates']['longitude']
		}
	end
	
	JSON.generate(results)
end