class Field < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  has_many :bookmarks, dependent: :destroy
end
