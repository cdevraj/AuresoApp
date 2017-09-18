class Car < ActiveRecord::Base

  #scope :by_slug, -> (slug) { where(slug: slug).first }

  def self.by_slug(slug)
    find_by_slug(slug)
  end

  def max_speed_on_track(params={})
    'no track selected'
  end
end
