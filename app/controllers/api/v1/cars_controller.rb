class Api::V1::CarsController < ApplicationController
  respond_to :json
  include Roar::Rails::ControllerAdditions

  def index
    car = Car.by_slug(params[:slug])
    puts "car------#{car.inspect}"
    if car
      respond_with car , represent_with: Api::V1::CarRepresenter
    else
      render json: {error: "car #{params[:slug]} could not be found"}
    end
  end

  private
  def track_params
    params.permit(:slug, :track)
  end

end