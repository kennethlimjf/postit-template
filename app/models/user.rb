class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  validates :username, presence: true, uniqueness: true, on: :create
  validates :password, length: { minimum: 8 }, on: :create
end