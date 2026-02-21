require 'rails_helper'

RSpec.describe Pref, type: :model do
  it "利用可能な都道府県データを保持していること" do
    expect(described_class.all.map(&:id)).to eq([31, 33, 34])
    expect(described_class.all.map(&:name)).to eq(%w(鳥取県 岡山県 広島県))
  end
end
