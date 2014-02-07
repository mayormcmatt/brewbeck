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

    def check_exists
    end

    def search
        if params
            style_id = params[:beer][:style_search]
            abv_search = params[:beer][:abv_search]
            ibu_search = params[:beer][:ibu_search]

            response = Typhoeus.get("http://api.brewerydb.com/v2/beers?styleId=#{style_id}&key=5a0a2875bbd1e7931736df7a5672f65f")
            @parsed = JSON.parse(response.response_body)

            @parsed["data"].each do |info|
                @refreshment = Refreshment.find_or_create_by(name: info["name"])
                @refreshment.abv =  info["abv"]
                @refreshment.ibu =  info["ibu"]
                @refreshment.save
            end

            if abv_search == "low"
                @refreshment =  Refreshment.where("abv < 6.5")
            elsif abv_search == "high"
                @refreshment =  Refreshment.where("abv >= 6.5")
            end

            if ibu_search == "smooth"
                @refreshment =  Refreshment.where("ibu < 35")
            elsif abv_search == "bitter"
                @refreshment =  Refreshment.where("ibu >=35")
            end
            @output = @refreshment
        end
    end

    def show
    end

end
