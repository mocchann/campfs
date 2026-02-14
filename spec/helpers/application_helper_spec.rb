require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "page_titleが空のときベースタイトルを返すこと" do
      expect(helper.full_title(page_title: '')).to eq("TO_CAMP")
    end

    it "page_titleがあるとき結合したタイトルを返すこと" do
      expect(helper.full_title(page_title: 'キャンプ場一覧')).to eq("キャンプ場一覧 △ TO_CAMP")
    end

    it "page_titleがnilでもベースタイトルを返すこと" do
      expect(helper.full_title(page_title: nil)).to eq("TO_CAMP")
    end
  end

  describe "#default_meta_tags" do
    let(:request_double) { double(original_url: "https://example.com/fields", base_url: "https://example.com") }

    it "必要なメタ情報を返すこと" do
      allow(helper).to receive(:request).and_return(request_double)

      tags = helper.default_meta_tags

      expect(tags[:title]).to be_present
      expect(tags[:description]).to be_present
      expect(tags[:noindex]).to eq(true)
      expect(tags.dig(:og, :url)).to eq("https://example.com/fields")
      expect(tags.dig(:twitter, :card)).to eq("summary")
    end

    it "iconとog:imageを含むこと" do
      allow(helper).to receive(:request).and_return(request_double)

      tags = helper.default_meta_tags

      expect(tags[:icon]).to be_present
      expect(tags[:icon].first[:href]).to include("favicon.ico")
      expect(tags.dig(:og, :image)).to include("top-img.jpg")
    end

    it "twitterカード情報を含むこと" do
      allow(helper).to receive(:request).and_return(request_double)

      tags = helper.default_meta_tags

      expect(tags.dig(:twitter, :card)).to eq("summary")
      expect(tags.dig(:twitter, :site)).to eq("@freebblog")
    end

    it "production環境ではnoindexがfalseになること" do
      allow(helper).to receive(:request).and_return(request_double)
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))

      tags = helper.default_meta_tags

      expect(tags[:noindex]).to eq(false)
    end
  end
end
