class SpeedCalculator
  def initialize(time_zone: time_zone, slow_factor: slow_factor, max_speed_of_car: nil, with_time_zone: false)
    @time_zone = time_zone
    @slow_factor = slow_factor
    @max_speed_of_car = max_speed_of_car
    @with_time_zone = with_time_zone
  end

  def calculate_speed_on_track
    return 0 unless @max_speed_of_car
    max_speed_on_track = @max_speed_of_car - percent_of(@slow_factor.to_f)
    return max_speed_on_track unless @with_time_zone
    max_speed_on_track - percent_of(get_slow_down_percentage(@time_zone).to_f) 
  end

  def percent_of(factor)
    (factor / @max_speed_of_car.to_f) * 100.0
  end

  def get_slow_down_percentage(time_zone)
    zone_time = DateTime.now.in_time_zone(time_zone)
    begining_of_day = zone_time.beginning_of_day
    return 0 if zone_time.between?(
      begining_of_day + 9.hours, begining_of_day + 18.hours
      )
    return 15 if zone_time.between?(
            begining_of_day + (
          21.hours + 30.minutes + 1.second
          ), begining_of_day.end_of_day
        ) || zone_time.between?(
      begining_of_day, begining_of_day + 6.hours
    )
    8
  end
end
