require File.expand_path("../spec_helper", __FILE__)

describe GoogleGeocoding::Request do
  describe "request creation" do
    it "should create a request with valid params" do
      lambda { factory(:request) }.should_not raise_error(GoogleGeocoding::InvalidRequestParametersError)
    end
  
    it "should raise InvalidRequestParametersError when address is missing" do
      lambda { factory(:request, :address => nil) }.should raise_error(GoogleGeocoding::InvalidRequestParametersError) do |error|
        error.on_param(:address).should include(:required)
      end
    end
  end
  
  describe "request usage" do  
    before :each do
      @request = factory(:request, :address => "2 Townsend St, San Francisco, CA", :sensor => true)
    end
    
    it "should return the query string" do
      @request.query_string.should == "address=2+Townsend+St%2C+San+Francisco%2C+CA&sensor=true"
    end
  end
end