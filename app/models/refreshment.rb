class Refreshment < ActiveRecord::Base

    # def check_exists
    #     @beer_record = Refreshment.find_by_name(self.name)
    #     if @beer_record != nil

    # end

    # def self.api_call
    #     if params
    #             search_str = params[:beer][:style_search]
    #             response = Typhoeus.get("http://api.brewerydb.com/v2/beers?styleId=#{search_str}&key=5a0a2875bbd1e7931736df7a5672f65f")
    #             @parsed = JSON.parse(response.response_body)
    #     end
    # end
end
