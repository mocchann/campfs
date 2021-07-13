class Field < ApplicationRecord
  has_many :reviwes, dependent: :destroy
  has_many :users, through: :reviews
  has_many :bookmarks, dependent: :destroy
end
