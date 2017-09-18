module Api::V1::CarRepresenter
  include Roar::JSON
  nested :data do
    nested :car do  
      property :id  
      property :slug  
      property :get_max_speed, as: :max_speed
      # property :max_speed_on_track, getter: lambda { |opts| opts[:track] }
    end
  end


  def get_max_speed
    return "0 Km/hr" unless self.max_speed
    "#{self.max_speed} Km/hr"
  end
end
