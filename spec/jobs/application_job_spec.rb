require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it "ActiveJob::Baseを継承していること" do
    expect(described_class < ActiveJob::Base).to eq(true)
  end
end
