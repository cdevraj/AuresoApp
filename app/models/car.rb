class Car < ActiveRecord::Base

  scope :by_slug, -> (slug) { where(slug: slug) }

  def max_speed_on_track(params={})
    'no track selected'
  end
end
