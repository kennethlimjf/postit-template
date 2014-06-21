module Voteable
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
end