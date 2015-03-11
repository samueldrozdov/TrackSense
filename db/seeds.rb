# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sam = User.create!(username: 'sam', email: 'sam@example.com', password: 'password', password_confirmation: 'password')

group1 = Group.create!(name: 'Newell Road', owner_id: sam.id)
sam.join(group1)
group1.save

group2 = Group.create!(name: 'Super Awesome Mega Group', owner_id: sam.id)
sam.join(group2)
group2.save

group3 = Group.create!(name: 'MakeSchool', owner_id: sam.id)
sam.join(group3)
group3.save

track1 = Track.create!(
        external_link: "https://soundcloud.com/usher-raymond-music/usher-i-dont-mind-feat-juicy-j",
        artist: "Usher Raymond Music",
        track_length: 200,
        track_name: "Usher - I Don't Mind feat. Juicy J",
        artwork_url: "https://i1.sndcdn.com/artworks-000098222482-ilxm2s-large.jpg",
        discovered_by: sam.id
)
Submission.create!(
        name: track1.track_name,
        user_id: sam.id,
        group_id: group1.id,
        track_id: track1.id,
).save
track1.save

# track2 = Track.create(
#         external_link: "https://soundcloud.com/mmmusic/mark-ronson-uptown-funk",
#         artist: "MMMusic",
#         track_length: 201,
#         track_name: "Mark Ronson- Uptown Funk",
#         artwork_url: "https://i1.sndcdn.com/artworks-000099014702-k1huxu-large.jpg"
# )
# Submission.create(
#         name: track2.track_name,
#         user_id: sam.id,
#         group_id: group2.id,
#         track_id: track2.id
# ).save
# track2.save

track3 = Track.create(
        external_link: "https://soundcloud.com/octobersveryown/makonnen-ft-drake-tuesday",
        artist: "octobersveryown",
        track_length: 223,
        track_name: "ILOVEMAKONNEN ~ Tuesday Feat. Drake",
        artwork_url: "https://i1.sndcdn.com/artworks-000089711243-lyy02l-large.jpg",
        discovered_by: sam.id
)
Submission.create(
        name: track3.track_name,
        user_id: sam.id,
        group_id: group2.id,
        track_id: track3.id
).save
track3.save

track4 = Track.create(
        external_link: "https://soundcloud.com/samsmithworld/samsmithasaprocky",
        artist: "SAM SMITH",
        track_length: 224,
        track_name: "Sam Smith - I'm Not The Only One feat. A$AP Rocky",
        artwork_url: "https://i1.sndcdn.com/artworks-000090531453-yy72cf-large.jpg",
        discovered_by: sam.id
)
Submission.create(
        name: track4.track_name,
        user_id: sam.id,
        group_id: group3.id,
        track_id: track4.id
).save
track4.save

# track5 = Track.create(
#         external_link: "https://soundcloud.com/missfinesse/the-weeknd-earned-it-1",
#         artist: "miss finesse",
#         track_length: 226,
#         track_name: "The Weeknd - Earned It",
#         artwork_url: "https://i1.sndcdn.com/artworks-000102990146-hy874z-large.jpg"
# )
# Submission.create(
#         name: track5.track_name,
#         user_id: sam.id,
#         group_id: group3.id,
#         track_id: track5.id
# ).save
# track5.save
