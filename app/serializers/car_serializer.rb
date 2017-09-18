class CarSerializer < ActiveModel::Serializer
  attributes :id, :slug, :get_max_speed, :max_speed_on_track

  def max_speed_on_track
    if @instance_options[:track]
      "#{@instance_options[:track].get_metadata(object.max_speed).to_i} Km/hr"
    else
      'no track selected'
    end
  end

  def get_max_speed
    return "0 Km/hr" unless object.max_speed
    "#{object.max_speed} Km/hr"
  end
end