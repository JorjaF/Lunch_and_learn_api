class Favorite < ApplicationRecord
  belongs_to :user
  has_many :users, dependent: :destroy
  validates_presence_of :country, :recipe_link, :recipe_title
end
