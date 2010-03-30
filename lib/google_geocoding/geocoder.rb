module GoogleGeocoding    
  class Geocoder
    def self.query(address, options = {})
      self.new(options).query(address)
    end
    
    # Creates a new geocoder instance.
    # @see Geocoder#geocode
    def initialize(options = {})
      @options = options
      @sess = Patron::Session.new
      @sess.timeout = options[:timeout] || 10
      @sess.base_url = "http://maps.google.com/maps/api/geocode"
      @sess.headers['User-Agent'] = options[:user_agent]
    end

    # Performs a geocoding request against google for the given address.
    #
    # @param [String, #to_s]
    # @return [Response]
    def query(address)
      request  = Request.new(:address => address, :sensor => false)
      response = @sess.get("/json?#{request.query_string}")
  
      if (200...300).include?(response.status)
        Response.new(response.body)
      else
        raise Errors::HttpError.new(address, resp)
      end
    end
  end
end