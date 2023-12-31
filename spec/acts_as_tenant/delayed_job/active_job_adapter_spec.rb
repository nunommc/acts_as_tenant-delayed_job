require "rails_helper"
require_relative "../../support/delayed/backend/test"

class SimpleJob
  cattr_accessor :runs
  @runs = 0
  def perform
    self.class.runs += 1
  end

  def self.deserialize
  end

  def deserialize(args)
  end

  def perform_now
    ::Comment.create
  end
end

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

  it "runs the job in the scope of the tenant" do
    ActsAsTenant.current_tenant = account
    job # enqueues job with correct tenant

    # runs job in another process which doesn't have current tenant set
    ActsAsTenant.current_tenant = nil
    expect(Account).to receive(:find).with(1234).once { account }

    job.invoke_job
    expect(Comment.last).to have_attributes(
      account_id: 1234
    )
  end
end
