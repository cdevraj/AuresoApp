FactoryGirl.define do 
  factory :track do
    name 'track_name'
    surface_type 'snow'
    slow_factor 35
    time_zone 'CET'
  end

  trait :with_asphalt_track do 
    surface_type 'asphalt'
    slow_factor 10
  end

  trait :with_gravel_track do 
    surface_type 'gravel'
    slow_factor 20
  end
end