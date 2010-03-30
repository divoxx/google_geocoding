require File.expand_path("../../spec_helper", __FILE__)

describe Response do
  before :each do
    @result_inst  = mock(:result_instance, :<< => nil)
    @result_class = mock(:result_class, :new => @result_inst)
    @response     = Response.new(DATA, @result_class)
  end
  
  it "should provide status" do
    @response.status.should == :ok
  end
  
  it "should provide whether it is a successful request" do
    @response.should be_success
  end
  
  it "should provide whether it is a failure request" do
    @response.should_not be_failure
  end
  
  it "should provide the results" do
    args = {:types => ["street_address"], :address => "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA", :coordinates => [37.4219720, -122.0841430], :precision => "ROOFTOP"}
    @result_class.should_receive(:new).once.with(args).and_return(@result_inst)
    @response.results.should be_instance_of(Array)
    @response.results.each { |item| item.should be(@result_inst) }
  end
  
  DATA = <<-EOF
{
  "status": "OK",
  "results": [ {
    "types": [ "street_address" ],
    "formatted_address": "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
    "address_components": [ {
      "long_name": "1600",
      "short_name": "1600",
      "types": [ "street_number" ]
    }, {
      "long_name": "Amphitheatre Pkwy",
      "short_name": "Amphitheatre Pkwy",
      "types": [ "route" ]
    }, {
      "long_name": "Mountain View",
      "short_name": "Mountain View",
      "types": [ "locality", "political" ]
    }, {
      "long_name": "California",
      "short_name": "CA",
      "types": [ "administrative_area_level_1", "political" ]
    }, {
      "long_name": "United States",
      "short_name": "US",
      "types": [ "country", "political" ]
    }, {
      "long_name": "94043",
      "short_name": "94043",
      "types": [ "postal_code" ]
    } ],
    "geometry": {
      "location": {
        "lat": 37.4219720,
        "lng": -122.0841430
      },
      "location_type": "ROOFTOP",
      "viewport": {
        "southwest": {
          "lat": 37.4188244,
          "lng": -122.0872906
        },
        "northeast": {
          "lat": 37.4251196,
          "lng": -122.0809954
        }
      }
    }
  } ]
}
  EOF
end