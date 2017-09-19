class CarSerializer < ActiveModel::Serializer
  attributes :id, :slug, :max_speed, :max_speed_on_track  

  def max_speed_on_track
    return 'no track selected' if @instance_options[:track].blank?
    "#{@instance_options[:track].get_metadata(object.max_speed).to_i} Km/hr"
  end

  def max_speed
    return "0 Km/hr" unless object.max_speed
    "#{object.max_speed} Km/hr"
  end
end