describe Api::V1::CarsController, :type => :controller do

  context "when car doesnt exists" do
    it "responds with error message" do
      get :show, {id: 'unknown-car'}
      message = JSON.parse(response.body)['error']
      expect(message).to eq("car unknown-car could not be found")
    end
  end
  
  context "when car exists but track params are not passed" do
    before do
      FactoryGirl.create(:car)      
       get :show, {id: 'sabaru_impreza'}
    end

    it "should not responds with error message when car is present" do
      message = JSON.parse(response.body)['error']
      expect(message).to eq(nil)
    end

    it "responds responds with the exact response of car" do
      expect(JSON.parse(response.body)).to eq("data" => 
        {"car"=>
          {
            "id"=>1,
            "slug"=>"sabaru_impreza",
            "max_speed"=>"100 Km/hr",
            "max_speed_on_track"=>"no track selected"
          }
        }
      )
    end

    it "max_speed_on_track on track should be 'no track selected' when track is not provided" do
      expect(JSON.parse(response.body)['data']['car']['max_speed_on_track']).to eq("no track selected")
    end
  end
  
  context "when car exists and track params are  passed" do
    before do
      FactoryGirl.create(:car)
      FactoryGirl.create(:track)      
      get :show, {id: 'sabaru_impreza', track: 'track_name'}
    end

    let(:server_response) { JSON.parse(response.body) }

    it "responds responds with the exact response of car and max_speed_on_track is not 'no track selected'" do
      expect(server_response).to eq("data"=>{"car"=>{"id"=>1, "slug"=>"sabaru_impreza", "max_speed"=>"100 Km/hr", "max_speed_on_track"=>"65 Km/hr"}})
      expect(server_response['data']['car']['max_speed_on_track']).not_to eq("no track selected")
    end

    it "should return the calculated max speed based on track" do
      expect(server_response['data']['car']['max_speed_on_track']).to eq("65 Km/hr")
    end
  end

end