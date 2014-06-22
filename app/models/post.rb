class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true

  before_save { generate_slug(self, :title) }

  def create_vote(options={})
    user = options[:creator]
    if user.admin?
      vote = self.votes.build(creator: user, vote: options[:vote])
      vote.save(validate: false)
    else
      vote = self.votes.create(creator: user, vote: options[:vote])
    end
    vote
  end
end