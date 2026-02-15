require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe "validation" do
    it "userとfieldの組み合わせが一意であること" do
      user = create(:user)
      field = create(:field)
      create(:bookmark, user: user, field: field)

      bookmark = build(:bookmark, user: user, field: field)

      expect(bookmark).not_to be_valid
      expect(bookmark.errors[:user_id]).to include("はすでに存在します")
    end

    it "userがnilだと無効であること" do
      bookmark = build(:bookmark, user: nil)

      expect(bookmark).not_to be_valid
      expect(bookmark.errors[:user]).to be_present
    end

    it "fieldがnilだと無効であること" do
      bookmark = build(:bookmark, field: nil)

      expect(bookmark).not_to be_valid
      expect(bookmark.errors[:field]).to be_present
    end

    it "重複組み合わせをcreate!するとRecordInvalidになること" do
      user = create(:user)
      field = create(:field)
      create(:bookmark, user: user, field: field)

      expect do
        create(:bookmark, user: user, field: field)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "association" do
    it "userに紐づくこと" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it "fieldに紐づくこと" do
      association = described_class.reflect_on_association(:field)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "dependent destroy" do
    it "user削除時にbookmarkも削除されること" do
      user = create(:user)
      field = create(:field)
      create(:bookmark, user: user, field: field)

      expect do
        user.destroy
      end.to change(described_class, :count).by(-1)
    end

    it "field削除時にbookmarkも削除されること" do
      user = create(:user)
      field = create(:field)
      create(:bookmark, user: user, field: field)

      expect do
        field.destroy
      end.to change(described_class, :count).by(-1)
    end
  end
end
