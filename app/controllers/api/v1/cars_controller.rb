class Api::V1::CarsController < ApplicationController
	respond_to :json

	def index
		car = Car.by_slug(params[:slug]).first
		track = Track.by_name(params[:track]).first if params[:track]
		if car
			render json: {data: {car: CarSerializer.new(car, {track: track})}}
		else
			render json: {error: "car #{params[:slug]} could not be found"}
		end
	end
end