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
      @sess.timeout = 5
      @sess.base_url = "http://maps.google.com/maps/geo"
      @sess.headers['User-Agent'] = options[:user_agent]
    end

    # Performs a geocoding request against google for the given address.
    #
    # @param [String, #to_s]
    # @return [Response]
    def query(address)
      params = "?q=#{URI.encode(address.to_s)}"
      params << "&key=#{@options[:api_key]}" if @options[:api_key]
      resp = @sess.get(params)
  
      if (200...300).include?(resp.status)
        Response.new(resp.body)
      else
        raise GeocodeError.new(address, resp)
      end
    end
  end
end