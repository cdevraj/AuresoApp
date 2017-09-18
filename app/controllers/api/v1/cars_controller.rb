class Api::V1::CarsController < ApplicationController
  respond_to :json

  def show
    puts params[:track]
      car = Car.by_slug(params[:slug]).first
      track = Track.find_by_name(params[:track]) if params[:track]
    if car
    	render json: {data: {car: CarSerializer.new(car, {track: track})}}
    else
      render json: {error: "car #{params[:slug]} could not be found"}
    end
  end

end