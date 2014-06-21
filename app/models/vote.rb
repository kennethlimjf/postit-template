class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true

  validates :vote, :inclusion => { :in => [-1,1] }
  validates_presence_of :creator
  validates_uniqueness_of :creator, scope: :voteable
end