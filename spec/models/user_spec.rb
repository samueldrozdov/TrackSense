require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:votes) }
  it { should have_many(:submissions) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }

end
