class Api::V1::CarsController < ApplicationController
  # respond_to :json

  def show
    car = Car.friendly.find(params[:id]) rescue nil
    track = Track.by_name(params[:track]).first if params[:track]
    if car
      render json: {data: {car: CarSerializer.new(car, {track: track, track_params: params[:track]})}}
    else
      render json: {error: "car #{params[:id]} could not be found"}
    end
  end
end