module GoogleGeocoding
  # Model that represents a placemark returned by the geocoding service.
  class Placemark
    # The level of accurracy for the placemark
    # @see http://code.google.com/apis/maps/documentation/geocoding/index.html#GeocodingAccuracy
    attr_accessor :accurracy
    
    # The country name
    attr_accessor :country_name
    
    # The country ISO code
    # @see http://www.iso.org/iso/country_codes/iso_3166_code_lists/english_country_names_and_code_elements.htm
    attr_accessor :country_code
    
    # The region/province/state
    attr_accessor :region
    
    # The city name
    attr_accessor :city
    
    # The postal/zip code
    attr_accessor :postal_code
    
    # The street address, including the number
    attr_accessor :street
    
    # An array with two positions: latitude and longitude
    attr_accessor :coordinates
  end
end