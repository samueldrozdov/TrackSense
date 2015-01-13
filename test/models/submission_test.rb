require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(username: 'sam', 
                        email: 'sam@example.com', 
                        password: 'password', 
                        password_confirmation: 'password')
    @submission = @user.submissions.build(external_link: 'https://soundcloud.com/odesza/sia-big-girls-cry-odesza-remix',
                                          name: "Big Girls Cry (ODESZA remix)",
                                          artist: 'ODESZA',
                                          track_length: 266)
    @submission.save
    @test = @user.submissions.build(external_link: 'https://soundcloud.com/disclosuremusic/latch-ft-sam-smith',
                                    name: "Latch ft. Sam Smith",
                                    artist: "Disclosure",
                                    track_length: 242)
  end

  test "valid submission should save" do
    assert @test.save
  end

  test "submission with same external link should not save" do
    @test.external_link = @submission.external_link
    assert_not @test.save
  end

  test "submission with same name and artist should not save" do
    @test.name = @submission.name
    @test.artist = @submission.artist
    assert_not @test.save
  end
end
