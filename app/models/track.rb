class Track < ActiveRecord::Base
  def slow_down_for_zone(max_speed_of_car, time_zone)
    # get current time in the zone
    # if falls in the difference 
    # retun slow down factor speed
    time = set_time_zone do
      p Time.zone.now
    end
    percentage = case time
    when time.hour > 9  && time.hour <= 18
      0
    when time.hour > 18 && (time.hour <= 21 && time.minute <=30)
      8
    when (time.hour > 21 && time.minute > 30) && time.hour <= 6
      15
    when time.hour > 6 && time.hour <= 9
      8
    else
      0     
    end
    percent_of(max_speed_of_car, factor: percentage)
  end

  def set_time_zone(&block)
    time_zone = self&.time_zone || 'CET'
    Time.use_zone(time_zone, &block)
  end

  def percent_of(max_speed_of_car, factor: self.slow_factor.to_f)
    ( factor/max_speed_of_car.to_f )*100.0
  end
end