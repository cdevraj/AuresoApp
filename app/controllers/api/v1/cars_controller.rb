class Api::V1::CarsController < ApplicationController
  before_action :set_car, :set_track, only: :show

  def show
    if @car
      render json: { data: { car: CarSerializer.new(@car, { track_name: params[:track], track: @track }) } }
    else
      render json: { error: "car #{params[:id]} could not be found" }
    end
  end

  private
  
  def set_car
    @car = Car.friendly.find_by(slug: params[:id])
  end

  def set_track
    @track = Track.find_by_name(params[:track])
  end
end