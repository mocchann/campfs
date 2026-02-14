require 'rails_helper'

RSpec.describe DeviseHelper, type: :helper do
  describe "#bootstrap_alert" do
    it "alertをwarningに変換すること" do
      expect(helper.bootstrap_alert("alert")).to eq("warning")
    end

    it "noticeをsuccessに変換すること" do
      expect(helper.bootstrap_alert("notice")).to eq("success")
    end

    it "dangerをdangerに変換すること" do
      expect(helper.bootstrap_alert("danger")).to eq("danger")
    end

    it "未知のキーはnilを返すこと" do
      expect(helper.bootstrap_alert("info")).to be_nil
    end
  end
end
