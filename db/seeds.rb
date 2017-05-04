# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@gomi = Gomi.new
@gomi.name = "燃えるゴミ"
@gomi.every = true
@gomi.start_date = 28
@gomi.tues = true
@gomi.fri = true
@gomi.save