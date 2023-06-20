# frozen_string_literal: true

require_relative "delayed_job/version"

module ActsAsTenant
  module DelayedJob
  end
end


ActiveSupport.on_load(:active_record) do |base|
  require "delayed_job"

  require_relative "delayed_job/delayed_job_backend"
  require_relative "delayed_job/active_job_adapter"
end
