# frozen_string_literal: true

require "delayed_job"
require_relative "delayed_job/version"
require_relative "delayed_job/delayed_job_backend"
require_relative "delayed_job/active_job_adapter"

module ActsAsTenant
  module DelayedJob
  end
end
