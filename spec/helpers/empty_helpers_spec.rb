require 'rails_helper'

RSpec.describe "empty helpers", type: :helper do
  describe BookmarksHelper do
    it "モジュールが定義されていること" do
      expect(BookmarksHelper).to be_a(Module)
    end
  end

  describe ContactsHelper do
    it "モジュールが定義されていること" do
      expect(ContactsHelper).to be_a(Module)
    end
  end

  describe HomeHelper do
    it "モジュールが定義されていること" do
      expect(HomeHelper).to be_a(Module)
    end
  end

  describe StaticPagesHelper do
    it "モジュールが定義されていること" do
      expect(StaticPagesHelper).to be_a(Module)
    end
  end

  describe UsersHelper do
    it "モジュールが定義されていること" do
      expect(UsersHelper).to be_a(Module)
    end
  end
end
