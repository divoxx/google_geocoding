module GoogleGeocoding
  class Response
    # Creates a new response object from the given response body, expects to be a JSON string.
    #
    # @param [String]
    def initialize(resp_body)
      @data = JSON.parse(resp_body)
    end
    
    # Return the status code included in the server response.
    #
    # @return [Integer] 
    # @see http://code.google.com/apis/maps/documentation/geocoding/index.html#StatusCodes
    def status_code
      Integer(@data["Status"]["code"])
    end
    
    # Return whether response successfully resolved the geolocation
    def success?
      status_code == 200
    end
    
    # Return whether response failed to resolved the geolocation
    def failure?
      !success?
    end
    
    # Return the placemarks included in the response.
    #
    # @return [Array<Placemark>]
    def placemarks
      if failure?
        raise Errors::ServiceError.build(status_code)
      else
        placemarks = []
        
        @data["Placemark"].each do |placemark_data|
          details               = placemark_data["AddressDetails"]
          coordinates           = placemark_data["Point"]["coordinates"][2..1]
          accurracy             = Integer(details["Accuracy"])
          placemark             = Placemark.new
          placemark.accurracy   = accurracy
          placemark.coordinates = coordinates
          
          next if accurracy >= 9

          if accurracy >= 1
            country = details["Country"]
            placemark.country_name = country["CountryName"],
            placemark.country_code = country["CountryNameCode"]
            
            if accurracy >= 2
              admarea = country["AdministrativeArea"]
              placemark.region = admarea["AdministrativeAreaName"]
              
              if accurracy >= 3
                subadmarea = admarea["SubAdministrativeArea"]
                
                if accurracy >= 4
                  locality = subadmarea ? subadmarea["Locality"] : admarea["Locality"]
                  placemark.city = locality["LocalityName"]
                  
                  if accurracy >= 5
                    placemark.postal_code = locality["PostalCode"]["PostalCodeNumber"]
                  end
                  
                  if accurracy >= 6
                    placemark.street = locality["Thoroughfare"]["ThoroughfareName"]
                  end
                end
              end
            end
          end
          
          placemarks << placemark
        end
        placemarks
      end
    end
  end
end