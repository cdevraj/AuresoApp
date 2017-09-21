describe CarSerializer, type: :serializer do

  context "when track, track params and car are present" do
    let(:car) { create(:car) }
    let(:track) { build(:track) }
    let(:serialized) { serialize(car, { track_name: track.name, track: track }) }

    it 'should have a slug that matches' do
      expect(json(serialized)['slug']).to eql(car.slug)
    end

    it 'should have a max_speed that matches' do
      expect(json(serialized)['max_speed']).to eql("#{car.max_speed} Km/hr")
    end

    it 'should have a max_speed on track that matches' do
      expect(json(serialized)['max_speed_on_track']).to eql("65.0 Km/hr")
    end
  end

  context "when track_params is present but track not found" do
    let(:car) { create(:car) }
    let(:serialized) { serialize(car, { track_name: 'unknown-tracks' }) }

    it 'should have a max_speed on track that matches track not found' do
      expect(json(serialized)['max_speed_on_track']).to eql("track not found")
    end

  end

  context "when track is not provided" do
    let(:car) { create(:car) }
    let(:serialized) { serialize(car) }

    it "should have max_speed_on_track as 'no track selected'" do
      expect(json(serialized)['max_speed_on_track']).to eql('no track selected')
    end
  end

  context 'when track, track params, with time zone and car are present' do
    let(:car) { create(:car) }
    let(:track) { build(:track) }
    let(:serialized) { serialize(car, track_name: track.name, track: track, with_time_zone: true) }

    it 'should have a slug that matches' do
      expect(json(serialized)['slug']).to eql(car.slug)
    end

    it 'should have a max_speed that matches' do
      expect(json(serialized)['max_speed']).to eql("#{car.max_speed} Km/hr")
    end

    it 'should have a max_speed on track that matches' do
      Timecop.freeze("2am") do
        expect(json(serialized)['max_speed_on_track']).to eql('50.0 Km/hr')
      end
    end
  end
end