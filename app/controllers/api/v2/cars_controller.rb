class Api::V2::CarsController < ApplicationController
  def show
    car = Car.friendly.find(params[:id]) rescue nil
    if car
      render json: {data: {car: CarSerializer.new(car, {track_name: params[:track], with_time_zone: true})}}
    else
      render json: {error: "car #{params[:id]} could not be found"}
    end
  end
end