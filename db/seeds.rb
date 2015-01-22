# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sam = User.create!(username: 'sam', email: 'sam@example.com', password: 'password', password_confirmation: 'password')

sam.submissions.build(external_link: 'https://soundcloud.com/odesza/sia-big-girls-cry-odesza-remix',
                      name: "Big Girls Cry (ODESZA remix)",
                      artist: 'ODESZA',
                      track_length: 266).save

sam.submissions.build(external_link: 'https://soundcloud.com/user7941120/queen-we-will-rock-you',
                      artist: 'Queen',
                      score: 10,
                      name: 'We Will Rock You',
                      track_length: 187).save

sam.submissions.build(external_link: 'https://soundcloud.com/umesongs/scorpions-rock-you-like-a',
                      artist: 'Scorpions',
                      score: 15,
                      name: 'Rock You Like a Hurricane',
                      track_length: 101).save

sub = sam.submissions.build(external_link: 'https://soundcloud.com/arayeofcolours/hotbox',
                            artist: 'RAYE.',
                            score: 0,
                            name: 'Hotbox',
                            track_length: 255)
sub.created_at = 1.day.ago
sub.save

sub2 = sam.submissions.build(external_link: 'https://soundcloud.com/siloarts/mpa-water-lyf',
                             artist: 'Silo Arts & Records',
                             score: 0,
                             name: 'Motion Picture Actress - Water Lyf (feat. Keiiko)',
                             track_length: 271)
sub2.created_at = 2.days.ago
sub2.save
