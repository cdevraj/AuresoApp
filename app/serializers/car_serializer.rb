class CarSerializer < ActiveModel::Serializer
  attributes :id, :slug, :max_speed, :max_speed_on_track  

  def max_speed_on_track
    return 'no track selected' if @instance_options[:track_name].blank?
    track = Track.by_name(@instance_options[:track_name]).first
    return 'track not found' if track.blank?
    "#{track.get_metadata(object.max_speed, @instance_options[:with_time_zone]).to_f} Km/hr"
  end

  def max_speed
    return "0 Km/hr" unless object.max_speed
    "#{object.max_speed} Km/hr"
  end
end