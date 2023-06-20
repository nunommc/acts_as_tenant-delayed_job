require "rails_helper"
require_relative "../../support/delayed/backend/test"

RSpec.describe "Delayed::Job" do
  let(:account) { Account.new(id: 1234) }
  let(:job_args) do
    ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper.new(
      "job_class" => "SimpleJob",
      "job_id" => "ae5cfaf8-2704-4bfe-8b8a-5ecc70e9e6f5"
    )
  end
  let(:job) do
    Delayed::Backend::Test::Job.enqueue(job_args, queue: "mailers")
  end

  it "saves tenant if present" do
    ActsAsTenant.current_tenant = account

    expect(job.queue).to eq("mailers")
    expect(job.payload_object.job_data).to include("acts_as_tenant" => {"tenant_class" => "Account", "tenant_id" => 1234})
  end

  it "does not set tenant if not present" do
    expect(ActsAsTenant.current_tenant).to be_nil

    expect(job.queue).to eq("mailers")
    expect(job.payload_object.job_data).not_to include("acts_as_tenant")
  end
end
