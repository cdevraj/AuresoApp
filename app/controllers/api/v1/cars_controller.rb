class Api::V1::CarsController < ApplicationController
  respond_to :json
  include Roar::Rails::ControllerAdditions

  def index
    puts params[:track]
      car = Car.by_slug(params[:slug]).first
      track = Track.find_by_name(params[:track]) if params[:track]
    if car
      track_details = track.get_metadata(car)
      respond_with car, :track_details => track_details
    else
      render json: {error: "car #{params[:slug]} could not be found"}
    end
  end

end