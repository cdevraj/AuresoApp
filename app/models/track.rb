class Track < ActiveRecord::Base


  def get_metadata(car)
    max_speed_of_car = car.max_speed
    max_speed_on_track = max_speed_of_car - percent_of(max_speed_of_car)
  end


   def percent_of(max_speed_of_car)
    self.slow_factor.to_i / max_speed_of_car.to_i * 100.0
  end
end