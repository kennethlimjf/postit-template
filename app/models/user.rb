class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  validates :username, presence: true, uniqueness: true, on: :create
  validates :password, length: { minimum: 8 }, on: :create
  validate :time_zone_is_valid

  def time_zone_is_valid
    errors[:time_zone] << "is a invalid time zone." unless Time.find_zone(time_zone)
  end
end