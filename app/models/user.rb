class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon_img
  attribute :new_icon_img

  before_save do
    if new_icon_img
      self.icon_img = new_icon_img
    end
  end
end