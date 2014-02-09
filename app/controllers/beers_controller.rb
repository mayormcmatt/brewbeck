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

    def search
        if params
            style_id_num = params[:beer][:style_search]
            abv_search = params[:beer][:abv_search]
            ibu_search = params[:beer][:ibu_search]

            response = Typhoeus.get("http://api.brewerydb.com/v2/beers?styleId=#{style_id_num}&key=5a0a2875bbd1e7931736df7a5672f65f")
            @parsed = JSON.parse(response.response_body)

            @parsed["data"].each do |info|
                @refreshment = Refreshment.find_or_create_by(name: info["name"])
                @refreshment.style_id = info["styleId"].to_s
                @refreshment.abv =  info["abv"]
                @refreshment.ibu =  info["ibu"]
                @refreshment.save
            end

            if style_id_num == "25"
                @refreshment = Refreshment.where("style_id = '25'")
            elsif style_id_num == "110"
                @refreshment = Refreshment.where("style_id = '110'")
            elsif style_id_num == "42"
                @refreshment = Refreshment.where("style_id = '42'")
            end

            if abv_search == "low"
                @refreshment =  @refreshment.where("abv < 6.5")
            elsif abv_search == "high"
                @refreshment =  @refreshment.where("abv >= 6.5")
            end

            if ibu_search == "smooth"
                @refreshment =  @refreshment.where("ibu < 35")
            elsif abv_search == "bitter"
                @refreshment =  @refreshment.where("ibu >=35")
            end

        end
    end

    def show
    end

end
