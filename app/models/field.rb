class Field < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  has_many :bookmarks, dependent: :destroy
  paginates_per 9
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :place_id, uniqueness: true
  has_one_attached :image
end
