module GoogleGeocoding
  # Encapsulation of the request information to be sent to the API endpoing.
  class Request
    # Creates a new request.
    #
    # @param [Hash] params hash of the parameters for the request. Valid parameters are:
    #   - address (required) - The address that you want to geocode.
    #   - *OR* latlng (required) - The textual latitude/longitude value for which you wish to obtain the closest, human-readable address.
    #   - bounds (optional) - The bounding box of the viewport within which to bias geocode results more prominently.
    #   - region (optional) - The region code, specified as a ccTLD ("top-level domain") two-character value.
    #   - language (optional) - The language in which to return results. See the supported list of domain languages.
    #   - sensor (required) - Indicates whether or not the geocoding request comes from a device with a location sensor. This value must be either true or false.
    #
    # @raise InvalidRequestParametersError
    def initialize(params = {})
      @params = params.dup
      check_params!
    end
    
    # Return the request query string.
    # @return [String]
    def query_string
      @params.map { |param, value| "#{CGI.escape(param.to_s)}=#{CGI.escape(value.to_s)}" }.join("&")
    end

  private
    def check_params!
      error = Errors::InvalidParametersError.new(self)
      
      if @params[:address].nil?
        error.add(:address, :required)
      end
      
      if @params[:required] && @params[:latlng].nil?
        error.add(:latlng, :required)
      end
      
      if @params[:sensor].nil?
        error.add(:sensor, :required)
      elsif ![true, false].include?(@params[:sensor])
        error.add(:sensor, :boolean)
      end
      
      raise error unless error.empty?
    end
  end
end