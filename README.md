# simple-Yelp
Simple interface for searching Yelp ([for restaurants](https://github.com/hywn/simple-Yelp/blob/gh-pages/yelp_api.rb#L46)) written using HTML/CSS/JS and Ruby

## stuff used
- [Yelp Fusion](https://github.com/Yelp/yelp-fusion): Yelp API
- [Sinatra](http://sinatrarb.com/)/[sinatra-cross_origin](https://github.com/britg/sinatra-cross_origin): Ruby web framework
- [Leaflet](https://leafletjs.com/): JavaScript map-rendering library

## project structure
```
Configuration
        Gemfile      -- dependency configuration
        Gemfile.lock -- dependency configuration
        config.ru    -- run configuration

Server/API
        yelp_api.rb  -- gets data from Yelp Fusion
        my_api.rb    -- processes data from Yelp Fusion
        server.rb    -- serves processed data

Interface
        index.html   -- interface for using server.rb
```