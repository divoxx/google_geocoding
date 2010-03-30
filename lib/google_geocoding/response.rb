module GoogleGeocoding
  class Response
    # Creates a new response object from the given response body, expects to be a JSON string.
    #
    # @param [String]
    def initialize(payload, result_class = nil)
      @data         = JSON.parse(payload)
      @result_class = result_class || GoogleGeocoding.const_get(:Result)
    end

    # Return the status code included in the server response.
    #
    # @return [Symbol]
    # @see http://code.google.com/apis/maps/documentation/geocoding/#StatusCodes
    def status
      @status ||= @data["status"].downcase.to_sym
    end

    # Return whether response successfully resolved the geolocation
    def success?
      status == :ok
    end

    # Return whether response failed to resolved the geolocation
    def failure?
      !success?
    end
    
    # Return the types of the result
    def results
      @result ||= @data["results"].map do |result_data|
        result = @result_class.new(
          :types       => result_data["types"],
          :address     => result_data["formatted_address"],
          :coordinates => result_data["geometry"]["location"].values_at("lat", "lng"),
          :precision   => result_data["geometry"]["location_type"]
        )
        
        result_data["address_components"].each do |addr_comp_data|
          result << AddressComponent.new(:short_name => addr_comp_data["short_name"], :long_name => addr_comp_data["long_name"], :types => addr_comp_data["types"])
        end
        
        result
      end
    end
  end
end