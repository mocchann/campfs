require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  subject(:admin_user) { described_class.new(email: "admin@example.com", password: "password123") }

  it "有効なemailとpasswordがあれば有効であること" do
    expect(admin_user).to be_valid
  end

  it "emailが空だと無効であること" do
    admin_user.email = nil

    expect(admin_user).not_to be_valid
    expect(admin_user.errors[:email]).to be_present
  end

  it "passwordが空だと無効であること" do
    admin_user.password = nil

    expect(admin_user).not_to be_valid
    expect(admin_user.errors[:password]).to be_present
  end

  it "重複したemailでは無効であること" do
    create(:admin_user, email: "admin@example.com", password: "password123")

    expect(admin_user).not_to be_valid
    expect(admin_user.errors[:email]).to be_present
  end

  it "passwordが5文字以下だと無効であること" do
    admin_user.password = "12345"

    expect(admin_user).not_to be_valid
    expect(admin_user.errors[:password]).to be_present
  end
end
