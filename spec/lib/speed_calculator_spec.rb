describe 'SpeedCalculator' do
  context '#calculate_speed_on_track' do
    describe "when track surface_type is snow" do
      let(:snow_track) { build :track }

      it "should return the metadata as 0 when max speed of the car is nil" do
        speed_calculator = SpeedCalculator.new
        expect(speed_calculator.calculate_speed_on_track).to eq(0)
      end

      it "should return the metadata when max speed of the car is provided" do
        speed_calculator = SpeedCalculator.new(time_zone: snow_track.time_zone, slow_factor: snow_track.slow_factor, max_speed_of_car: 100)
        expect(speed_calculator.calculate_speed_on_track).to eq(65.0)
      end
    end

    describe "when track surface_type is asphalt_track" do
      let(:asphalt_track) { build :track, :with_asphalt_track }

      it "should return the metadata as 0 when max speed of the car is nil" do
        speed_calculator = SpeedCalculator.new
        expect(speed_calculator.calculate_speed_on_track).to eq(0)
      end

      it "should return the metadata when max speed of the car is provided" do
        speed_calculator = SpeedCalculator.new(time_zone: asphalt_track.time_zone, slow_factor: asphalt_track.slow_factor, max_speed_of_car: 100)
        expect(speed_calculator.calculate_speed_on_track).to eq(90.0)
      end
    end

    describe "when track surface_type is gravel" do
      let(:gravel_track) { build :track, :with_gravel_track }

      it "should return the metadata as 0 when max speed of the car is nil" do
        speed_calculator = SpeedCalculator.new
        expect(speed_calculator.calculate_speed_on_track).to eq(0)
      end

      it "should return the metadata when max speed of the car is provided" do
        speed_calculator = SpeedCalculator.new(time_zone: gravel_track.time_zone, slow_factor: gravel_track.slow_factor, max_speed_of_car: 100)
        expect(speed_calculator.calculate_speed_on_track).to eq(80.0)
      end
    end
  end

  context '#percent_of' do
    describe "when track surface_type is snow" do
      let(:snow_track) { build :track }
      
      it "should return the percent factor for the car in snow_track" do
        speed_calculator = SpeedCalculator.new(time_zone: snow_track.time_zone, slow_factor: snow_track.slow_factor, max_speed_of_car: 100)
        expect(speed_calculator.percent_of(snow_track.slow_factor)).to eq(35.0)
      end
    end

    describe "when track surface_type is snow" do
      let(:asphalt_track) { build :track, :with_asphalt_track }

      it "should return the percent factor for the car in asphalt_track" do
        speed_calculator = SpeedCalculator.new(time_zone: asphalt_track.time_zone, slow_factor: asphalt_track.slow_factor, max_speed_of_car: 100)
        expect(speed_calculator.percent_of(asphalt_track.slow_factor)).to eq(10.0)
      end
    end

    describe "when track surface_type is gravel_track" do
      let(:gravel_track) { build :track, :with_gravel_track }

      it "should return the percent factor for the car in gravel_track" do
        speed_calculator = SpeedCalculator.new(time_zone: gravel_track.time_zone, slow_factor: gravel_track.slow_factor, max_speed_of_car: 100)
        expect(speed_calculator.percent_of(gravel_track.slow_factor)).to eq(20.0)
      end
    end
  end

  describe '#get_slow_down_percentage' do
    #currently the time zone is freezed to CET +2:00
    let(:snow_track) { build :track }  
    let(:speed_calculator) { SpeedCalculator.new(with_time_zone: true, time_zone: snow_track.time_zone) }
    
    it "should return the get_slow_down_percentage when current driving time is between 9am to 6pm " do
      Timecop.freeze("2pm")
      expect(speed_calculator.get_slow_down_percentage(snow_track.time_zone)).to eql(0)
    end

    it "should return the get_slow_down_percentage when current driving time is between 6pm to 9:30pm " do
      Timecop.freeze("7pm")
      expect(speed_calculator.get_slow_down_percentage(snow_track.time_zone)).to eql(8)
    end

    it "should return the get_slow_down_percentage when current driving time is between 9:30pm to 6am " do
      Timecop.freeze("1am")
      expect(speed_calculator.get_slow_down_percentage(snow_track.time_zone)).to eql(15)
    end

    it "should return the get_slow_down_percentage when current driving time is between 6am to 9:30pm " do
      Timecop.freeze("5pm")
      expect(speed_calculator.get_slow_down_percentage(snow_track.time_zone)).to eql(8)
    end
  end
end
