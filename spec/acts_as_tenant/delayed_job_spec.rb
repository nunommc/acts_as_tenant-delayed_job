# frozen_string_literal: true

RSpec.describe ActsAsTenant::DelayedJob do
  it "has a version number" do
    expect(ActsAsTenant::DelayedJob::VERSION).not_to be nil
  end
end
