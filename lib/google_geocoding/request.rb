module GoogleGeocoding
  # Error representing that the parameters provided to the request are invalid.
  class InvalidRequestParametersError < BaseError
    def initialize(request)
      @request  = request
      @messages = Hash.new { |h,k| h[k] = [] }
    end

    # Add a error message for the given param.
    def add(param, identifier)
      @messages[param] << identifier
    end
    
    # Returns the messages for the given param
    def on(param)
      @messages[param]
    end

    # Returns a descriptive message of the error.
    def message
      message = "Some of the request parameters are invalid:"      
      @messages.each { |param, identifiers|  message << "\n  * #{param}: #{identifiers.join(', ')}" }
      message
    end

    # Alias to_s to messages for easy terminal output
    alias_method :to_s, :message
    
    # Returns true/false for whether there are an error on any params
    def empty?
      @messages.empty?
    end
  end

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
      error = InvalidRequestParametersError.new(self)
      
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