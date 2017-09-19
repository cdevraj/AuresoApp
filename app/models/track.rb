class Track < ActiveRecord::Base
  scope :by_name, ->(name) { where(name: name) }
  
  def get_metadata(max_speed_of_car, with_time_zone)
    return 0 unless max_speed_of_car
    max_speed_on_track = max_speed_of_car - percent_of(max_speed_of_car)
    return max_speed_on_track unless with_time_zone
    max_speed_on_track - percent_of(max_speed_of_car, factor: get_slow_down_percentage.to_f) 
  end

  def percent_of(max_speed_of_car, factor: self.slow_factor.to_f)
    ( factor / max_speed_of_car.to_f ) * 100.0
  end

  def get_slow_down_percentage
    zone_time = DateTime.now.in_time_zone(time_zone)
    begining_of_day = zone_time.beginning_of_day
    return 0 if zone_time.between?(begining_of_day + 9.hours, begining_of_day + 18.hours)
    return 15 if zone_time.between?(begining_of_day + (21.hours + 30.minutes + 1.second), begining_of_day.end_of_day) || zone_time.between?(begining_of_day, begining_of_day + 6.hours)
    8
  end
end