require 'rails_helper'

RSpec.describe Track, type: :model do

  context ".get_metadata and .percent_of" do
    describe "when track surface_type is snow" do
      let(:snow_track) { build :track }
      it "should return the metadata as 0 when max speed of the car is nil" do
        expect(snow_track.get_metadata(nil, false)).to eq(0)
      end
      it "should return the metadata when max speed of the car is provided" do
        expect(snow_track.get_metadata(100, false)).to eq(65.0)
      end
      it "should return the percent factor for the car" do
        expect(snow_track.percent_of(100)).to eq(35.0)
      end
    end

    describe "when track surface_type is asphalt_track" do
      let(:asphalt_track) { build :track, :with_asphalt_track }
      it "should return the metadata as 0 when max speed of the car is nil" do
        expect(asphalt_track.get_metadata(nil, false)).to eq(0)
      end
      it "should return the metadata when max speed of the car is provided" do
        expect(asphalt_track.get_metadata(100, false)).to eq(90.0)
      end
      it "should return the percent factor for the car" do
        expect(asphalt_track.percent_of(100)).to eq(10.0)
      end
    end

    describe "when track surface_type is gravel" do
      let(:gravel_track) { build :track, :with_gravel_track }
      it "should return the metadata as 0 when max speed of the car is nil" do
        expect(gravel_track.get_metadata(nil, false)).to eq(0)
      end
      it "should return the metadata when max speed of the car is provided" do
        expect(gravel_track.get_metadata(100, false)).to eq(80.0)
      end
      it "should return the percent factor for the car" do
        expect(gravel_track.percent_of(100)).to eq(20.0)
      end
    end
  end

  describe '#get_slow_down_percentage' do
    let(:snow_track) { build :track }
    
    it "should return the slow_down_percentage when current driving time is between 9am to 6pm " do
      allow_any_instance_of(Date).to receive(:in_time_zone).and_return(DateTime.parse("5pm"))
      expect(snow_track.get_slow_down_percentage).to eql(0)
    end

    it "should return the slow_down_percentage when current driving time is between 6pm to 9:30pm " do
      allow_any_instance_of(Date).to receive(:in_time_zone).and_return(DateTime.parse("8pm"))
      expect(snow_track.get_slow_down_percentage).to eql(8)
    end

    it "should return the slow_down_percentage when current driving time is between 9:30pm to 6am " do
      allow_any_instance_of(Date).to receive(:in_time_zone).and_return(DateTime.parse("6am"))
      expect(snow_track.get_slow_down_percentage).to eql(15)
    end

    it "should return the slow_down_percentage when current driving time is between 6am to 9:30pm " do
      allow_any_instance_of(Date).to receive(:in_time_zone).and_return(DateTime.parse("8am"))
      expect(snow_track.get_slow_down_percentage).to eql(8)
    end
  end
end
