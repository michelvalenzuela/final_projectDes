class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
         has_many :subscriptions
  has_many :communities, through: :subscriptions
  has_many :posts
  has_many :comments
  has_many :votes

  validates_presence_of :first_name, :last_name, :username

  def self.from_omniauth(access_token)
    account = Account.where(email: access_token.info.email).first
    unless account
      account = Account.create(first_name:access_token.info.name,
        last_name:access_token.info.name,
        username: access_token.info.name,
        email: access_token.info.email,
        password: Devise.friendly_token[0,20]
      )
    end
    account.email = access_token.info.email
    account.username = access_token.info.name
    account.uid = access_token.uid
    account.provider = access_token.provider
    account.save

    account
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def upvoted_post_ids
    self.votes.where(upvote: true).pluck(:post_id)
  end

  def downvoted_post_ids
    self.votes.where(upvote: false).pluck(:post_id)
  end
end
