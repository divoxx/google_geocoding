module GoogleGeocoding
  class Response
    # Creates a new response object from the given response body, expects to be a JSON string.
    #
    # @param [String]
    def initialize(io, result_class = nil)
      @data         = JSON.parse(io.read)
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
      @result ||= @data["results"].map { |result| @result_class.new(result) }
    end
  end
end