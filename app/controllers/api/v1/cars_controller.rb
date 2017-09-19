class Api::V1::CarsController < ApplicationController
  def show
    car = Car.friendly.find(params[:id]) rescue nil
    if car
      render json: {data: {car: CarSerializer.new(car, {track_name: params[:track]})}}
    else
      render json: {error: "car #{params[:id]} could not be found"}
    end
  end
end