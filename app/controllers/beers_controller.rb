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
    end

    def search
        if params
            style_id = params[:beer][:style_search]
            abv_search = params[:beer][:abv_search]
            ibu_search = params[:beer][:ibu_search]
            response = Typhoeus.get("http://api.brewerydb.com/v2/beers?styleId=#{style_id}&key=5a0a2875bbd1e7931736df7a5672f65f")
            @parsed = JSON.parse(response.response_body)

            # @beer_list_hash = []

            @parsed["data"].each do |info|
                @refreshment = Refreshment.new(

                    name: info["name"],
                    abv: info["abv"].to_i,
                    ibu: info["ibu"].to_i
                    )
                # # @refreshment.save
                # beer_list = {}
                # beer_list[:name] = info["name"],
                # beer_list[:abv] = info["abv"].to_i,
                # beer_list[:ibu] = info["ibu"].to_i

                if abv_search == "low" && @refreshment[:abv] < 6.5
                    abv_ok = true
                elsif abv_search == "high" && @refreshment[:abv] >= 6.5
                    abv_ok = true
                else
                    abv_ok = false
                end

                if ibu_search == "smooth" && @refreshment[:ibu] < 40
                    ibu_ok = true
                elsif ibu_search == "bitter" && @refreshment[:ibu] >= 40
                    ibu_ok = true
                else 
                    ibu_ok = false
                end

                if abv_ok == true && ibu_ok == true
                    # @beer_list_hash.push(beer_list)
                    @refreshment.save
                end
            end

            # beer_list = @parsed["data"]
            # beer_list.each do |info|
            #     @refreshment = Refreshment.new(
            #         name: info["name"],
            #         abv: info["abv"],
            #         ibu: info["ibu"]
            #         )
            #     @refreshment.save
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
