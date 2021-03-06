class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  has_slug :name
end