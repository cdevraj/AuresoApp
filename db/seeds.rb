# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Car.destroy_all
Car.create({slug: 'subaru_impreza', max_speed: 280})

Track.destroy_all
Track.create({name: 'nurburgring', surface_type: 'snow', slow_factor: (20..35).to_a.sample})
Track.create({name: 'sydney_motorsport_park', surface_type:'gravel', slow_factor:  (10..19).to_a.sample})
Track.create({name: 'guia_circut', surface_type: 'asphalt', slow_factor: (1..9).to_a.sample})
  