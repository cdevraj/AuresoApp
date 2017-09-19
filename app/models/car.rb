class Car < ActiveRecord::Base
  scope :by_slug, ->(slug) { where(slug: slug) }

end