require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(username: 'sam', 
                        email: 'sam@example.com', 
                        password: 'password', 
                        password_confirmation: 'password')
    @submission = @user.submissions.build(external_link: 'https://soundcloud.com/odesza/sia-big-girls-cry-odesza-remix',
                                          name: "Big Girls Cry (ODESZA remix)",
                                          artist: 'ODESZA',
                                          score: 0,
                                          name: 'Bitches be cryin',
                                          track_length: 266)
    @submission.save
  end

  test "user can vote on submission" do
    vote = @user.votes.build(votable_type: :Submission, 
                      votable_id: @submission.id)
    assert vote.save
  end

  test "user can't vote twice on submission" do
    @user.votes.build(votable_type: :Submission, 
                      votable_id: @submission.id).save
    vote = @user.votes.build(votable_type: :Submission, 
                      votable_id: @submission.id)
    assert_not vote.save
  end
end
