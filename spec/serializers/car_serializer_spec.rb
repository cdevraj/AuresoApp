describe CarSerializer do

  context "when track, track params and car are present" do
    before do
      # Create an instance of the model
      @car = FactoryGirl.create(:car)
      @track = FactoryGirl.create(:track)

      # Create a serializer instance
      @serializer = CarSerializer.new(@car, { track_name: @track.name })

      # Create a serialization based on the configured adapter
      @serialization = ActiveModelSerializers::Adapter.create(@serializer)
    end

    subject { JSON.parse(@serialization.to_json) }

    it 'should have a slug that matches' do
      expect(subject['slug']).to eql(@car.slug)
    end
    it 'should have a max_speed that matches' do
      expect(subject['max_speed']).to eql("#{@car.max_speed} Km/hr")
    end
    it 'should have a max_speed on track that matches' do
      expect(subject['max_speed_on_track']).to eql("65.0 Km/hr")
    end
  end

  context "when track_params is present but track not found" do
    before do
      # Create an instance of the model
      @car = FactoryGirl.create(:car)
      # Create a serializer instance
      @serializer = CarSerializer.new(@car, {track_name: 'unknow'})

      # Create a serialization based on the configured adapter
      @serialization = ActiveModelSerializers::Adapter.create(@serializer)
    end

    subject { JSON.parse(@serialization.to_json) }

    it 'should have a max_speed on track that matches track not found' do
      expect(subject['max_speed_on_track']).to eql("track not found")
    end

  end

  context "when track is not provided" do
    before do
      # Create an instance of the model
      @car = FactoryGirl.create(:car)

      # Create a serializer instance
      @serializer = CarSerializer.new(@car)

      # Create a serialization based on the configured adapter
      @serialization = ActiveModelSerializers::Adapter.create(@serializer)
    end

    subject { JSON.parse(@serialization.to_json) }

    it "should have max_speed_on_track as 'no track selected'"do
      expect(subject['max_speed_on_track']).to eql('no track selected')
    end
  end
end