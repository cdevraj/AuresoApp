describe Api::V1::CarsController, :type => :api do

  context "when car doesnt exists" do
    it "responds with error message" do
      get '/api/v1/cars/unknown-car'
      message = json['error']
      expect(message).to eq("car unknown-car could not be found")
    end
  end
  
  context "when car exists but track params are not passed" do
    before do
      FactoryGirl.create(:car)      
      get '/api/v1/cars/name'
    end

    it "should not responds with error message when car is present" do
      message = json['error']
      expect(message).to eq(nil)
    end

    it "responds responds with the exact response of car" do
      get '/api/v1/cars/name'
      expect(json).to eq("data" => 
        {"car"=>
          {
            "id"=>1,
            "slug"=>"name",
            "max_speed"=>"100 Km/hr",
            "max_speed_on_track"=>"no track selected"
          }
        }
      )
    end

    it "max_speed_on_track on track should be 'no track selected when track is not provided" do
      get '/api/v1/cars/name'
      expect(json['data']['car']['max_speed_on_track']).to eq("no track selected")
    end
  end
  
  context "when car exists and track params are  passed" do
    before do
      FactoryGirl.create(:car)
      FactoryGirl.create(:track)      
      get '/api/v1/cars/name'
    end

    it "responds responds with the exact response of car and max_speed_on_track is not 'no track selected'" do
      get '/api/v1/cars/name?track=track_name'
      expect(json).to eq("data"=>{"car"=>{"id"=>1, "slug"=>"name", "max_speed"=>"100 Km/hr", "max_speed_on_track"=>"65 Km/hr"}})
      expect(json['data']['car']['max_speed_on_track']).not_to eq("no track selected")
    end

    it "should return the calculated max speed based on track" do
      get '/api/v1/cars/name?track=track_name'
      expect(json['data']['car']['max_speed_on_track']).to eq("65 Km/hr")
    end
  end

end