class Car < ActiveRecord::Base

  scope :by_slug, -> (slug) { where(slug: slug) }

  def get_max_speed
    return "0 Km/hr" unless self.max_speed
    "#{self.max_speed} Km/hr"
  end
  
  def max_speed_on_track(params={})
    'no track selected'
  end
end
