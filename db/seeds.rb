# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sam = User.create!(username: 'sam', email: 'sam@example.com', password: 'password', password_confirmation: 'password')

sam.submissions.build(external_link: 'https://soundcloud.com/odesza/sia-big-girls-cry-odesza-remix',
                      artist: 'ODESZA',
                      score: 0,
                      track_length: 266).save
