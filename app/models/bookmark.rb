class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :field

  validates :user_id, uniqueness: { scope: :field_id }
end
