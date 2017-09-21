class CarSerializer < ActiveModel::Serializer
  attributes :id, :slug, :max_speed, :max_speed_on_track  

  def max_speed_on_track
    return 'no track selected' if @instance_options[:track_name].blank?
    track = @instance_options[:track]
    return 'track not found' if track.blank?
    speed_calculator = SpeedCalculator.new(time_zone: track.time_zone,
                                           slow_factor: track.slow_factor,
                                           max_speed_of_car: object.max_speed,
                                           with_time_zone: @instance_options[:with_time_zone])
    "#{speed_calculator.calculate_speed_on_track.to_f} Km/hr"
  end

  def max_speed
    return "0 Km/hr" unless object.max_speed
    "#{object.max_speed} Km/hr"
  end
end