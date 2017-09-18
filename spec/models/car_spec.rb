require 'rails_helper'

RSpec.describe Car, type: :model do

	let(:car) { build(:car) }

	it "should return the max speed in Km/hr" do
		expect(car.get_max_speed).to eq('100 Km/hr')
	end

	it "should return the max speed as 0 Km/hr when max_speed is not defined for car" do
		car.max_speed = nil
		expect(car.get_max_speed).to eq('0 Km/hr')
	end
end
