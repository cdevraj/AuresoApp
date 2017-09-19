class Car < ActiveRecord::Base
   extend FriendlyId

  scope :by_slug, ->(slug) { where(slug: slug) }

  friendly_id :slug, use: :slugged
  
end