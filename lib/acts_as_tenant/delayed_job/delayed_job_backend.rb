# Monkeypatches the #enqueue method on Delayed::Backend::Base so that it stores
# information about the tenant the enqueued the job.

module Delayed
  module Backend
    module Base
      module ClassMethods
        # Add a job to the queue
        def enqueue(*args)
          if ActsAsTenant.current_tenant
            args[0].job_data["acts_as_tenant"] = {
              "tenant_class" => ActsAsTenant.current_tenant.class.name,
              "tenant_id" => ActsAsTenant.current_tenant.id
            }
          end

          job_options = Delayed::Backend::JobPreparer.new(*args).prepare
          enqueue_job(job_options)
        end
      end
    end
  end
end
