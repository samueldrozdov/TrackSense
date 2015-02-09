class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_many :submissions
  has_many :votes
  has_many :voted_submissions, through: :votes, source: :votable, source_type: :Submission
  has_many :memberships, class_name: "GroupRelationship",
                          dependent: :destroy
  has_many :groups, through: :memberships, source: :user

  before_save { self.email = email.downcase }

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX } ,
                            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  # --Relationship methods--

  #joins a group
  def join(group)
    memberships.create!(group_id: group.id)
  end

  #leaves a group
  def leave(group)
    memberships.find_by(group_id: group.id).destroy
  end

  def all_groups
    memberships.collect { |a| a.group }
  end

  # --Security methods--

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # --Session methods--

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end
