class Track < ActiveRecord::Base
  scope :by_name, ->(name) { where(name: name) }
  
  def get_metadata(max_speed_of_car, time_zone: 'CET')
    return 0 unless max_speed_of_car
    max_speed_on_track = max_speed_of_car - (percent_of(max_speed_of_car) + slow_down_for_zone(max_speed_of_car, time_zone))
  end


  def slow_down_for_zone(max_speed_of_car, time_zone)
    # get current time in the zone
    # if falls in the difference 
    # retun slow down factor speed
    zone_time = DateTime.now.in_time_zone(time_zone)
    begining_of_day =  zone_time.beginning_of_day#zone_time.time.beginning_of_day
    percentage = 0

    if zone_time.between?(begining_of_day+9.hours, begining_of_day+18.hours)
      percentage = 0
    elsif zone_time.between?(begining_of_day+(18.hours+1.second), begining_of_day+(21.hours+30.minutes))
      percentage = 8
    elsif zone_time.between?(begining_of_day+(21.hours+30.minutes+1.second), begining_of_day+6.hours)
      percentage = 15
    elsif zone_time.between?(begining_of_day+6.hours, begining_of_day+(9.hours+30.minutes))
      percentage = 8
    else
      percentage = 0
    end        
    percent_of(max_speed_of_car, factor: percentage.to_f)  
  end

  def set_time_zone(&block)
    time_zone = self&.time_zone || 'CET'
    Time.use_zone(time_zone, &block)
  end

  def percent_of(max_speed_of_car, factor: self.slow_factor.to_f)
    ( factor/max_speed_of_car.to_f )*100.0
  end
end