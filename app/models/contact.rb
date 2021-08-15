class Contact < ApplicationRecord
  validates :email, presence: true, length: {maximum:255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :name, presence: true
  validates :message, presence: true, length: { maximum: 800 }
end
