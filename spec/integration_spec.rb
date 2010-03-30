require File.expand_path("../spec_helper", __FILE__)

describe "Full-stack geocoding (Integration test)" do
  before :each do
    @geocoder = GoogleGeocoding::Geocoder.new
  end
  
  it "should return successful response with valida address" do
    pending
    response = @geocoder.query("2 Townsend St, San Francisco, CA")
    response.status.should == :ok
    response.should be_success
  end  
end