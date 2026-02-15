require 'rails_helper'

RSpec.describe Field, type: :model do
  subject(:field) { build(:field) }

  describe "validation" do
    it "有効な属性を持つとき有効であること" do
      expect(field).to be_valid
    end

    it "nameが空だと無効であること" do
      field.name = nil

      expect(field).not_to be_valid
      expect(field.errors[:name]).to be_present
    end

    it "addressが空だと無効であること" do
      field.address = nil

      expect(field).not_to be_valid
      expect(field.errors[:address]).to be_present
    end

    it "place_idが重複すると無効であること" do
      existing = create(:field)
      field.place_id = existing.place_id

      expect(field).not_to be_valid
      expect(field.errors[:place_id]).to be_present
    end

    it "place_idがnilでも有効であること" do
      field.place_id = nil

      expect(field).to be_valid
    end

    it "nameが50文字以内なら有効であること" do
      field.name = "a" * 50

      expect(field).to be_valid
    end

    it "nameが51文字だと無効であること" do
      field.name = "a" * 51

      expect(field).not_to be_valid
      expect(field.errors[:name]).to be_present
    end

    it "addressが100文字以内なら有効であること" do
      field.address = "a" * 100

      expect(field).to be_valid
    end

    it "addressが101文字だと無効であること" do
      field.address = "a" * 101

      expect(field).not_to be_valid
      expect(field.errors[:address]).to be_present
    end
  end

  describe "association" do
    it "reviewsを削除連鎖すること" do
      association = described_class.reflect_on_association(:reviews)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "bookmarksを削除連鎖すること" do
      association = described_class.reflect_on_association(:bookmarks)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe "dependent destroy" do
    it "field削除時に関連reviewを削除すること" do
      user = create(:user)
      target_field = create(:field)
      create(:review, user: user, field: target_field)

      expect do
        target_field.destroy
      end.to change(Review, :count).by(-1)
    end
  end
end
