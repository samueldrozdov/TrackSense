require 'rails_helper'

RSpec.describe Submission, :type => :model do

  it { should_belong_to(:user) }

  it { should_have_many(:votes) }
  it { should_have_many(:genres) }

  it { should_validate_presence_of (:user_id) }
  it { should_validate_presence_of (:artist) }
  it { should_validate_presence_of (:track_length) }
  it { should_validate_presence_of (:external_link) }
  it { should_validate_presence_of (:name) }

end
