require File.expand_path("../../spec_helper", __FILE__)

describe Result do
  describe "result creation" do
    it "should create object and set properties" do
      result = Result.new(
        :types       => ["street_address"], 
        :address     => "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
        :coordinates => [37.4219720, -122.0841430],
        :precision   => "ROOFTOP"
      )
      
      result.types.should == [:street_address]
      result.address.should == "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
      result.coordinates.should == [37.4219720, -122.0841430]
      result.precision.should == :rooftop
    end
    
    it "should index address components by type" do
      result = Result.new(
        :types       => ["street_address"], 
        :address     => "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
        :coordinates => [37.4219720, -122.0841430],
        :precision   => "ROOFTOP"
      )
      result << num   = AddressComponent.new(:long_name => "1600", :short_name => "1600", :types => ["street_number"])
      result << route = AddressComponent.new(:long_name => "Amphitheatre Pkwy", :short_name => "Amphitheatre Pkwy", :types => ["route"])
      result << city  = AddressComponent.new(:long_name => "Mountain View", :short_name => "Mountain View", :types => ["political", "locality"])
      result << state = AddressComponent.new(:long_name => "California", :short_name => "CA", :types => ["political", "administrative_area_level_1"])
      result.get(:political).should == [city, state]
    end
    
    %w(types address coordinates precision).each do |missing_attr|
      it "should raise an error when #{missing_attr} is missing" do
        attrs = {
          :types       => ["street_address"], 
          :address     => "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
          :coordinates => [37.4219720, -122.0841430],
          :precision   => "ROOFTOP"
        }
        attrs.delete(missing_attr.to_sym)
        lambda { Result.new(attrs) }.should raise_error(Errors::InvalidParametersError)
      end
    end
  end
end