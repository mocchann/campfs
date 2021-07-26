class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  # validates :password, format: { with: VALID_PASSWORD_REGEX, message: "は半角6~12文字・英大文字・小文字・数字それぞれ１文字以上含む必要があります" }
  has_many :reviews, dependent: :destroy
  has_many :fields, through: :reviews
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_fields, through: :bookmarks, source: :field

  has_one_attached :icon_img
  attribute :new_icon_img

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  before_save do
    if new_icon_img
      self.icon_img = new_icon_img
    end
  end
end
