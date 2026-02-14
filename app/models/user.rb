class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GUEST_EMAIL = 'guest@example.com'.freeze
  GUEST_NAME = "ゲストユーザー".freeze

  has_many :reviews, dependent: :destroy
  has_many :fields, through: :reviews
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_fields, through: :bookmarks, source: :field
  before_save { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  # validates :password, format: { with: VALID_PASSWORD_REGEX, message: "は半角6~12文字・英大文字・小文字・数字それぞれ１文字以上含む必要があります" }
  validate :validate_icon_img
  paginates_per 9
  has_one_attached :icon_img
  attribute :new_icon_img
  before_validation :assign_new_icon_img

  def validate_icon_img
    return unless icon_img.attached?
    return if image?

    errors.add(:icon_img, "は画像データではありません。")
  end

  def image?
    %w(image/jpg image/jpeg image/png image/gif).include?(icon_img.blob.content_type)
  end

  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |user|
      user.name = GUEST_NAME
      user.password = SecureRandom.urlsafe_base64
    end
  end

  private

  def assign_new_icon_img
    return if new_icon_img.blank?

    self.icon_img = new_icon_img
  end
end
