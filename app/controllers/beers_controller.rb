require 'json'
require 'typhoeus'

#About BreweryDB API calls:
#Returns all beers based on style ID: http://api.brewerydb.com/v2/beers?styleId=110&key=5a0a2875bbd1e7931736df7a5672f65f

class BeersController < ApplicationController
#API Key:  5a0a2875bbd1e7931736df7a5672f65f
    def index
    end

    def new
        @refreshment = Refreshment.new()
    end

    def create
        # beer_name = @parsed["data"].each {|beer| beer["name"]}and iterate over the array to get name, abv and ibu
        # abv_value = @parsed["data"].each {|abv| abv["abv"]}
        # ibu_value = @parsed["data"].each {|ibu| ibu["ibu"]}
        # @refreshment = Refreshment.new(the info from the above iteration)
    end

    def search
        if params
            search_str = params[:beer][:style_search]
            response = Typhoeus.get("http://api.brewerydb.com/v2/beers?styleId=#{search_str}&key=5a0a2875bbd1e7931736df7a5672f65f")
            @parsed = JSON.parse(response.response_body)

            beer_list = @parsed["data"]
            beer_list.each do |info|
                @refreshment = Refreshment.new(
                    name: info["name"],
                    abv: info["abv"],
                    ibu: info["ibu"]
                    )
                @refreshment.save
            end

            # if params[:beer][:abv_search] == "low"
            #     Refreshment.where("abv < 6")
            #     @refreshments
            # end

        end
        # Logic will create branches depending on user answers and narrow down search options
        # Only one API call (mood will bring down one of three styles); search the existing JSON object
        # From @parsed get all beers over/under certain ABV; put in new @abv variable, use in next filter
        # From @abv get all beers over/under certain IBU; put in new @ibu variable
        # In show page display @ibu contents
    end

    def show
    end

end
