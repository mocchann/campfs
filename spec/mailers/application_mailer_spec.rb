require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it "ActionMailer::Baseを継承していること" do
    expect(described_class < ActionMailer::Base).to eq(true)
  end
end
