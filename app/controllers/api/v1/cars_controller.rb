class Api::V1::CarsController < ApplicationController
  def show
    car = Car.friendly.find(params[:id]) rescue nil
    track = Track.by_name(params[:track]).first if params[:track]
    if car
      render json: {data: {car: CarSerializer.new(car, {track: track})}}
    else
      render json: {error: "car #{params[:id]} could not be found"}
    end
  end
end