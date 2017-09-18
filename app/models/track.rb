class Track < ActiveRecord::Base
  scope :by_name, ->(name) { where(name: name) }

  def get_metadata(max_speed_of_car)
    return 0 unless max_speed_of_car
    max_speed_on_track = max_speed_of_car - percent_of(max_speed_of_car)
  end

  def percent_of(max_speed_of_car)
    (self.slow_factor.to_f / max_speed_of_car.to_f ) * 100.0
  end
end