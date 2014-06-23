module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes_score
    self.votes.inject(0){ |t, v| t + v.vote }
  end

  def up_votes_score
    up_votes.count
  end

  def down_votes_score
    down_votes.count
  end

  def up_votes
    self.votes.where(vote: 1)
  end

  def down_votes
    self.votes.where(vote: -1)
  end

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