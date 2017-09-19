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
    # zone_time = set_time_zone do
    #   p Time.zone.now
    # end
    # puts zone_time.time
    zone_time = DateTime.now.in_time_zone(time_zone)
    puts zone_time
    begining_of_day =  zone_time.beginning_of_day#zone_time.time.beginning_of_day
    # byebug

    percentage = case zone_time
    when zone_time.between?(begining_of_day+9.hours, begining_of_day+18.hours)
      0
    when zone_time.between?(begining_of_day+(18.hours+1.second), begining_of_day+(21.hours+30.minutes))
      # 6pm – 9.30pm | 8%
      puts "6pm – 9.30pm"
      8
    when zone_time.between?(begining_of_day+(21.hours+30.minutes+1.second), begining_of_day+6.hours)
      # 9.30pm – 6am | 15%
      puts "9.30pm – 6am"
      15
    when zone_time.between?(begining_of_day+6.hours, begining_of_day+(9.hours+30.minutes))
      # 6am – 9am | 8%  
      puts "6am – 9am"
      8
    else
      puts "else"
      raise "error"
      0     
    end
  end

  def set_time_zone(&block)
    time_zone = self&.time_zone || 'CET'
    Time.use_zone(time_zone, &block)
  end

  def percent_of(max_speed_of_car, factor: self.slow_factor.to_f)
    ( factor/max_speed_of_car.to_f )*100.0
  end
end